defmodule FoodOrderWeb.Live.LiveHelpers do
  use Phoenix.LiveComponent

  def modal(assigns) do
    ~H"""
    <div class="px-8 pt-6 pb-8 mb-4 bg-white rounded shadow-md phx-modal fade-in" data-role="modal">
      <div class="phx-modal-content fade-in-scale">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end
end
