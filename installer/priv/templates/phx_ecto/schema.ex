defmodule <%= @app_module %>.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id

      ## Starting point for restricting data to user or organisation
      ## https://hexdocs.pm/ecto/multi-tenancy-with-foreign-keys.html

      # require Ecto.Query
      # require <%= @app_module %>.Repo

      # @behaviour <%= @app_module %>.Policy

      # def restrict(_operation, query, opts)
      #     when <%= @app_module %>.Repo.schema_in_query?(query, __MODULE__) do
      #   if user_id = opts[:user_id] do
      #     {Ecto.Query.where(query, user_id: ^user_id), opts}
      #   else
      #     raise "expected user_id or skip_policy to be set"
      #   end
      # end

      # defoverridable <%= @app_module %>.Policy
    end
  end
end
