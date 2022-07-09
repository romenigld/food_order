defmodule FoodOrderWeb.Admin.ProductLive.Show do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products

  def mount(_params, _session, socket) do
    # socket = assign(socket, key: value)
    {:ok, socket}
  end

  def handle_params(%{"id" => id} = _params, _url, socket) do
    product = Products.get!(id)
    {:noreply, socket |> assign(product: product) |> assign(page_title: "Show!!!")}
  end
end
