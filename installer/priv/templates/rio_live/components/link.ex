defmodule <%= @web_namespace %>.Components.Link do
  use <%= @web_namespace %>, :component

  def link(assigns) do
    ~H"""
    <a href={@href} class={assigns[:class]}>
      <%%= render_slot(@inner_block) %>
    </a>
    """
  end
end
