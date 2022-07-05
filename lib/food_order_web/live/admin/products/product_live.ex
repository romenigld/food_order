defmodule FoodOrderWeb.Admin.ProductLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product
  alias FoodOrderWeb.Admin.Products.Form.FormComponent

  def mount(_params, _session, socket) do
    products = Products.list_products()
    {:ok, socket |> assign(products: products)}
  end

  def handle_params(params, _url, socket) do
    live_action = socket.assigns.live_action
    {:noreply, apply_action(socket, live_action, params)}
  end

  def apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Create new Product")
    |> assign(:product, %Product{})
  end

  def apply_action(socket, :edit, %{"id" => id}) do
    product = Products.get!(id)
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, product)
  end

  def apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "List Products")
    |> assign(:product, nil)
  end
end
