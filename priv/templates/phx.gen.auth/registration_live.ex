defmodule <%= inspect context.web_module %>.<%= inspect web_module_prefix %>RegistrationLive do
  use <%= inspect context.web_module %>, :live_view

  alias <%= inspect context.module %>
  alias <%= inspect schema.module %>
  alias <%= inspect context.web_module %>.<%= inspect web_module_prefix %>SessionLive

  def mount(_params, session, socket) do
    socket = assign_changeset(socket, session)
    {:ok, socket}
  end

  defp assign_changeset(socket, %{"changeset" => changeset} = _session) do
    assign(socket, changeset: changeset)
  end

  defp assign_changeset(socket, _session) do
    assign(socket, changeset: <%= inspect context.alias %>.change_<%= schema.singular %>_registration(%User{}))
  end
end
