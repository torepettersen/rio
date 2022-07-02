defmodule <%= @web_namespace %>.ButtonComponent do
  use <%= @web_namespace %>, :component

  @base_style "group inline-flex items-center justify-center rounded-full py-2 px-4 text-sm font-semibold focus:outline-none focus-visible:outline-2 focus-visible:outline-offset-2"
  @variant_style "bg-blue-600 text-white hover:text-slate-100 hover:bg-blue-500 active:bg-blue-800 active:text-blue-100 focus-visible:outline-blue-600"

  def button(%{href: _} = assigns) do
    ~H"""
    <a href={@href} class={class(assigns)}>
      <%%= render_slot(@inner_block) %>
    </a>
    """
  end

  defp class(_assigns) do
    Enum.join([@base_style, @variant_style], " ")
  end
end
