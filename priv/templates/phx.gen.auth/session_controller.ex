defmodule <%= inspect context.web_module %>.<%= inspect web_module_prefix %>SessionController do
  use <%= inspect context.web_module %>, :controller

  alias <%= inspect context.module %>
  alias <%= inspect auth_module %>
  alias <%= inspect context.web_module %>.<%= inspect web_module_prefix %>SessionLive

  def create(conn, %{"<%= schema.singular %>" => <%= schema.singular %>_params}) do
    %{"email" => email, "password" => password} = <%= schema.singular %>_params

    if <%= schema.singular %> = <%= inspect context.alias %>.get_<%= schema.singular %>_by_email_and_password(email, password) do
      <%= inspect schema.alias %>Auth.log_in_<%= schema.singular %>(conn, <%= schema.singular %>, <%= schema.singular %>_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      live_render(conn, <%= inspect web_module_prefix %>SessionLive,
        session: %{"error_message" => "Invalid email or password"}
      )
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> <%= inspect schema.alias %>Auth.log_out_<%= schema.singular %>()
  end
end
