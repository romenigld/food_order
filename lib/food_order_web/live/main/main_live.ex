defmodule FoodOrderWeb.MainLive do
  use FoodOrderWeb, :live_view
  alias FoodOrderWeb.Main.Hero
  alias FoodOrderWeb.Main.Items

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
