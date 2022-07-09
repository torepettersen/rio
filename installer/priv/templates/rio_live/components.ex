defmodule <%= @web_namespace %>.Components do
  # Components
  defdelegate alert(assigns), to: <%= @web_namespace %>.AlertComponent
  defdelegate button(assigns), to: <%= @web_namespace %>.ButtonComponent
  defdelegate container(assigns), to: <%= @web_namespace %>.ContainerComponent
  defdelegate form_input(assigns), to: <%= @web_namespace %>.FormInputComponent
  defdelegate link(assigns), to: <%= @web_namespace %>.LinkComponent
  defdelegate navbar(assigns), to: <%= @web_namespace %>.NavbarComponent

  # Icons
  defdelegate icon_x_circle(assigns), to: <%= @web_namespace %>.IconsComponent
end
