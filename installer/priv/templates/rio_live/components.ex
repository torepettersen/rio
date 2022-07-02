defmodule <%= @web_namespace %>.Components do
  alias <%= @web_namespace %>.Components

  defdelegate button(assigns), to: Components.Button
  defdelegate container(assigns), to: Components.Container
  defdelegate link(assigns), to: Components.Link
  defdelegate navbar(assigns), to: Components.Navbar
end
