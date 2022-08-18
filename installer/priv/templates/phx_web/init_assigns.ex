defmodule <%= @web_namespace %>.InitAssigns do
  # import Phoenix.LiveView

  # alias <%= @app_module %>.Accounts
  # alias <%= @app_module %>.Repo

  def on_mount(:default, _params, _session, socket) do
    # socket = assign_new(socket, :current_user, fn -> get_user(session) end)

    # Repo.put_user(socket.assigns.current_user)

    {:cont, socket}
  end

  # defp get_user(%{"user_token" => user_token} = _session) do
  #   Accounts.get_user_by_session_token(user_token)
  # end

  # defp get_user(_session), do: nil
end
