defmodule <%= @app_module %>.Repo.Migrations.DBSetup do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\"", ""
  end
end
