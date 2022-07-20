defmodule LiveSessions.PermissionsTest do
  use FoodOrderWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  describe "success when is admin" do
    setup :register_and_log_in_admin

    test "when admin is correct", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
      assert has_element?(view, "[data-role=product-actions][data-id=#{product.id}]")
    end
  end

  describe "success when is not admin" do
    setup :register_and_log_in_user

    test "when admin is wrong", %{conn: conn} do
      {:error, {:redirect, %{flash: %{"error" => message}, to: "/"}}} =
        live(conn, Routes.admin_product_path(conn, :index))

      assert message == "You don't have permissions to access this page"
    end
  end

  describe "success when user is not logged in" do
    test "whithout login", %{conn: conn} do
      {:error, {:redirect, %{flash: %{"error" => message}, to: "/users/log_in"}}} =
        live(conn, Routes.admin_product_path(conn, :index))

      assert message == "You must log in to access this page."
    end
  end
end
