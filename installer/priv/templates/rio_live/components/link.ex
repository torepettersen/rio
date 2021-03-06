defmodule <%= @web_namespace %>.LinkComponent do
  use <%= @web_namespace %>, :component

  def link(%{href: href} = assigns) do
    args =
      assigns
      |> Map.drop([:href, :inner_block])
      |> Enum.to_list()
      |> then(&[{:to, href} | &1])

    ~H"""
    <%%= link args do %>
      <%%= render_slot(@inner_block) %>
    <%% end %>
    """
  end
end
