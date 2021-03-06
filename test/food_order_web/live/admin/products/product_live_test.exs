defmodule FoodOrderWeb.ProductLiveTest do
  use FoodOrderWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  describe "test default page product" do
    setup :register_and_log_in_admin

    test "load page", %{conn: conn} do
      product = insert(:product)

      # {:ok, view, _html} = live(conn, "/admin/products")
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
      assert has_element?(view, "[data-role=product-section]")
      assert has_element?(view, "[data-role=product-table]")
      assert has_element?(view, "[data-id=head-name]", "Name")
      assert has_element?(view, "[data-id=head-price]", "Price")
      assert has_element?(view, "[data-id=head-size]", "Size")
      assert has_element?(view, "[data-id=head-actions]", "Actions")
      assert has_element?(view, "[data-role=product-list]")

      # test product
      assert has_element?(view, "[data-role=product-item][data-id=#{product.id}]")
      assert has_element?(view, "[data-role=product-name][data-id=#{product.id}]", product.name)

      assert has_element?(
               view,
               "[data-role=product-price][data-id=#{product.id}]",
               "R$2.00"
             )

      assert has_element?(view, "[data-role=product-size][data-id=#{product.id}]", product.size)

      assert has_element?(view, "[data-role=product-actions][data-id=#{product.id}]")
    end

    test "given a product that has already exists when click to delete then removes the product from the db",
         %{conn: conn} do
      product = insert(:product)

      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
      assert has_element?(view, "[data-role=delete][data-id=#{product.id}]", "Delete")

      assert view
             |> element("[data-role=delete][data-id=#{product.id}]", "Delete")
             |> render_click()

      refute has_element?(view, "[data-role=delete][data-id=#{product.id}]")
    end
  end
end
