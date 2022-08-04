defmodule <%= inspect context.web_module %>.<%= inspect web_module_prefix %>ResetPasswordLive do
  use <%= inspect context.web_module %>, :live_view

  alias Phoenix.View
  alias <%= inspect context.module %>
  alias <%= inspect context.web_module %>.<%= inspect web_module_prefix %>ResetPasswordView
  alias <%= inspect context.web_module %>.<%= inspect web_module_prefix %>SessionLive

  def mount(params, _session, socket) do
    socket = maybe_setup_edit_form(socket, params)
    {:ok, socket}
  end

  def render(%{live_action: :new} = assigns) do
    View.render(<%= inspect web_module_prefix %>ResetPasswordView, "new.html", assigns)
  end

  def render(%{live_action: :edit} = assigns) do
    View.render(<%= inspect web_module_prefix %>ResetPasswordView, "edit.html", assigns)
  end

  def handle_event("create_reset_token", %{"<%= schema.singular %>" => %{"email" => email}}, socket) do
    if <%= schema.singular %> = <%= inspect context.alias %>.get_<%= schema.singular %>_by_email(email) do
      <%= inspect context.alias %>.deliver_<%= schema.singular %>_reset_password_instructions(
        <%= schema.singular %>,
        &Routes.<%= schema.route_helper %>_reset_password_url(socket, :edit, &1)
      )
    end

    socket =
      socket
      |> put_flash(
        :info,
        "If your email is in our system, you will receive instructions to reset your password shortly."
      )
      |> push_redirect(to: "/")

    {:noreply, socket}
  end

  def handle_event("reset_password", %{"<%= schema.singular %>" => params}, %{assigns: %{<%= schema.singular %>: <%= schema.singular %>}} = socket) do
    socket =
      case <%= inspect context.alias %>.reset_<%= schema.singular %>_password(<%= schema.singular %>, params) do
        {:ok, _} ->
          socket
          |> put_flash(:info, "Password reset successfully.")
          |> push_redirect(to: Routes.live_path(socket, <%= inspect web_module_prefix %>SessionLive))

        {:error, changeset} ->
          assign(socket, changeset: changeset)
      end

    {:noreply, socket}
  end

  defp maybe_setup_edit_form(socket, %{"token" => token} = _params) do
    if <%= schema.singular %> = <%= inspect context.alias %>.get_<%= schema.singular %>_by_reset_password_token(token) do
      assign(socket, <%= schema.singular %>: <%= schema.singular %>, token: token, changeset: <%= inspect context.alias %>.change_<%= schema.singular %>_password(<%= schema.singular %>))
    else
      socket
      |> put_flash(:error, "Reset password link is invalid or it has expired.")
      |> push_redirect(to: "/")
    end
  end

  defp maybe_setup_edit_form(socket, _session), do: socket
end
