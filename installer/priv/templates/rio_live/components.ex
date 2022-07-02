defmodule <%= @web_namespace %>.Components do
  defdelegate button(assigns), to: <%= @web_namespace %>.ButtonComponent
  defdelegate container(assigns), to: <%= @web_namespace %>.ContainerComponent
  defdelegate link(assigns), to: <%= @web_namespace %>.LinkComponent
  defdelegate navbar(assigns), to: <%= @web_namespace %>.NavbarComponent
end
