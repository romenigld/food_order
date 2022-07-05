defmodule FoodOrderWeb.Admin.Products.Form.FormComponentTest do
  use FoodOrderWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  alias FoodOrder.Products
  import FoodOrder.Factory

  test "load product to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    #  the word "can't" as "can&#39;t is a HTML entities
    assert view
           |> form("#new", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"

    # to use the string with the normal word "can't" it uses the function html_entities_parse()
    assert view
           |> form("#new", product: %{name: nil})
           |> render_change() =~ "can't be blank" |> html_entities_parse()

    # and other way is using the Floki
    assert view
           |> form("#new", product: %{name: nil})
           |> render_change()
           |> Floki.parse_document!()
           |> Floki.find("span.invalid-feedback")
           |> Floki.text() =~ "can't be blank"
  end

  test "given a product when submit the form returns a succesful message", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    payload = %{name: "soda", description: "coca-cola", price: 100, size: "small"}

    {:ok, _, html} =
      view
      |> form("#new", product: payload)
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has created!"
    assert html =~ "soda"
  end

  test "given a product when submit the form then returns the changeset error", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    payload = %{name: "pumpking", description: "abc 123", price: 123, size: "small"}

    assert {:ok, _product} = Products.create_product(payload)

    assert view
           |> form("#new", product: payload)
           |> render_submit() =~ "has already been taken"
  end

  test "given a product that has already exist when cicked to edit then open the modal and excute an action",
       %{conn: conn} do
    product = insert(:product)
    # IO.inspect(product.name)

    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view |> element("[data-role=edit-product][data-id=#{product.id}]") |> render_click()
    assert view |> has_element?("#modal")

    assert_patch(view, Routes.admin_product_path(conn, :edit, product))

    assert view
           |> form("##{product.id}", product: %{name: nil})
           |> render_change() =~ "can't be blank" |> html_entities_parse()

    {:ok, view, html} =
      view
      |> form("##{product.id}", product: %{name: "juice"})
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product updated!"

    assert view |> has_element?("[data-role=product-name][data-id=#{product.id}]", "juice")
  end

  defp open_modal(view) do
    view
    |> element("[data-role=add-new-product]", "New")
    |> render_click()
  end
end
