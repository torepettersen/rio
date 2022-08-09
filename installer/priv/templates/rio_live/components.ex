defmodule <%= @web_namespace %>.Components do
  defdelegate alert(assigns), to: <%= @web_namespace %>.AlertComponent
  defdelegate button(assigns), to: <%= @web_namespace %>.ButtonComponent
  defdelegate container(assigns), to: <%= @web_namespace %>.ContainerComponent
  defdelegate form_input(assigns), to: <%= @web_namespace %>.FormInputComponent
  defdelegate link(assigns), to: <%= @web_namespace %>.LinkComponent
  defdelegate navbar(assigns), to: <%= @web_namespace %>.NavbarComponent
  defdelegate notifications(assigns), to: <%= @web_namespace %>.NotificationComponent
end
