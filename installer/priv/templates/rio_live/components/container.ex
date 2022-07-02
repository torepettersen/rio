defmodule <%= @web_namespace %>.ContainerComponent do
  use <%= @web_namespace %>, :component

  def container(assigns) do
    ~H"""
    <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
      <%%= render_slot(@inner_block) %>
    </div>
    """
  end
end
