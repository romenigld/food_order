defmodule FoodOrderWeb.Admin.Products.Form.FormComponentTest do
  use FoodOrderWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  import Phoenix.HTML

  test "load product to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view
           |> form("#new_product", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"

    assert view
           |> form("#new_product", product: %{name: nil})
           |> render_change() =~ "can't be blank" |> html_escape() |> safe_to_string()
  end
end
