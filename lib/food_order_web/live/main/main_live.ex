defmodule FoodOrderWeb.MainLive do
  use FoodOrderWeb, :live_view

  def mount(_params, _session, socket) do

    {:ok, socket |> assign(name: "Romenig", age: "38")}
  end
end
