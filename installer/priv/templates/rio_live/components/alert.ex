defmodule <%= @web_namespace %>.AlertComponent do
  use <%= @web_namespace %>, :component

  def alert(assigns) do
    ~H"""
    <div class="bg-red-50 border-l-4 border-red-400 p-4">
      <div class="flex">
        <div class="flex-shrink-0">
          <.icon_x_circle class="h-5 w-5 text-red-400" />
        </div>
        <div class="ml-3">
          <p class="text-sm text-red-700">
            <%%= render_slot(@inner_block) %>
          </p>
        </div>
      </div>
    </div>
    """
  end
end
