defmodule <%= inspect context.web_module %>.<%= inspect web_module_prefix %>RegistrationController do
  use <%= inspect context.web_module %>, :controller

  alias <%= inspect context.module %>
  alias <%= inspect auth_module %>
  alias <%= inspect context.web_module %>.<%= inspect web_module_prefix %>RegistrationLive

  def create(conn, %{"<%= schema.singular %>" => <%= schema.singular %>_params}) do
    case <%= inspect context.alias %>.register_<%= schema.singular %>(<%= schema.singular %>_params) do
      {:ok, <%= schema.singular %>} ->
        conn
        |> put_flash(:info, "<%= schema.human_singular %> created successfully.")
        |> <%= inspect schema.alias %>Auth.log_in_<%= schema.singular %>(<%= schema.singular %>)

      {:error, %Ecto.Changeset{} = changeset} ->
        live_render(conn, <%= inspect web_module_prefix %>RegistrationLive,
          session: %{"changeset" => changeset}
        )
    end
  end
end
