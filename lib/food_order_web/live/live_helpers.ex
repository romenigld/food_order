defmodule FoodOrderWeb.Live.LiveHelpers do
  use Phoenix.LiveComponent
  alias Phoenix.LiveView.JS

  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="px-8 pt-6 pb-8 mb-4 bg-white rounded shadow-md phx-modal fade-in" data-role="modal" phx-remove={hide_modal()}>
      <div id="modal-content"
           class="phx-modal-content fade-in-scale"
           phx-click-away={hide_modal()}
           phx-window-keydown={hide_modal()}
           phx-key="escape"
         >
         <button id="close" href="#" class="phx-modal-close" phx-click={hide_modal()}><small >x</small></button>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
