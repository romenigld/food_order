defmodule FoodOrderWeb.Admin.Products.Form.FormComponentTest do
  use FoodOrderWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  alias FoodOrder.Products

  test "load product to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    #  the word "can't" as "can&#39;t is a HTML entities
    assert view
           |> form("#new_product", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"

    # to use the string with the normal word "can't" it uses the function html_entities_parse()
    assert view
           |> form("#new_product", product: %{name: nil})
           |> render_change() =~ "can't be blank" |> html_entities_parse()

    # and other way is using the Floki
    assert view
           |> form("#new_product", product: %{name: nil})
           |> render_change()
           |> Floki.parse_document!()
           |> Floki.find("span.invalid-feedback")
           |> Floki.text() =~ "can't be blank"
  end

  test "given a product when submit the form returns a succesful message", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    payload = %{name: "soda", description: "coca-cola", price: 100, size: "small"}

    {:ok, _, html} =
      view
      |> form("#new_product", product: payload)
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has created."
    assert html =~ "soda"
  end

  test "given a product when submit the form then returns the changeset error", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    payload = %{name: "pumpking", description: "abc 123", price: 123, size: "small"}

    assert {:ok, _product} = Products.create_product(payload)

    assert view
           |> form("#new_product", product: payload)
           |> render_submit() =~ "has already been taken"
  end
end
