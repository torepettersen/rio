defmodule <%= @app_module %>.Repo do
  use Ecto.Repo,
    otp_app: :<%= @app_name %>,
    adapter: <%= inspect @adapter_module %>

  ## Starting point for restricting data to user or organisation
  ## https://hexdocs.pm/ecto/multi-tenancy-with-foreign-keys.html
  # require Ecto.Query

  # @user_key {__MODULE__, :user}

  # defguard schema_in_query?(query, module) when elem(query.from.source, 1) == module

  # @impl true
  # def prepare_query(operation, query, opts) do
  #   schema = elem(query.from.source, 1)

  #   if opts[:skip_policy] || opts[:schema_migration] do
  #     {query, opts}
  #   else
  #     schema.restrict(operation, query, opts)
  #   end
  # end

  # @impl true
  # def default_options(_operation) do
  #   [user_id: get_user_id()]
  # end

  # def put_user(user) do
  #   Process.put(@user_key, user)
  # end

  # def get_user do
  #   Process.get(@user_key)
  # end

  # def get_user_id do
  #   case get_user() do
  #     %{id: id} -> id
  #     _ -> nil
  #   end
  # end
end
