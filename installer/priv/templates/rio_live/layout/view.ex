defmodule <%= @web_namespace %>.LayoutView do
  use Phoenix.View,
    root: "lib/hello_web",
    namespace: <%= @web_namespace %>

  use Phoenix.HTML

  import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2]
  import Phoenix.LiveView.Helpers
  import <%= @web_namespace %>.Components

  alias <%= @web_namespace %>.Router.Helpers, as: Routes

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}
end
