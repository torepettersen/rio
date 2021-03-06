defmodule Rio.New.Single do
  use Rio.New.Generator

  alias Rio.New.Project

  @templates [
    new: [
      {:eex, "rio_live/config/config.exs", "config/config.exs"},
      {:eex, "rio_live/config/dev.exs", "config/dev.exs"},
      {:eex, "rio_live/config/prod.exs", "config/prod.exs"},
      {:eex, "rio_live/config/runtime.exs", "config/runtime.exs"},
      {:eex, "rio_live/config/test.exs", "config/test.exs"},
      {:eex, "phx_single/lib/app_name/application.ex", "lib/:app/application.ex"},
      {:eex, "phx_single/lib/app_name.ex", "lib/:app.ex"},
      {:keep, "phx_web/controllers", "lib/:lib_web_name/controllers"},
      {:eex, "phx_web/views/error_helpers.ex", "lib/:lib_web_name/views/error_helpers.ex"},
      {:eex, "phx_web/views/error_view.ex", "lib/:lib_web_name/views/error_view.ex"},
      {:eex, "phx_web/endpoint.ex", "lib/:lib_web_name/endpoint.ex"},
      {:eex, "phx_web/router.ex", "lib/:lib_web_name/router.ex"},
      {:eex, "phx_web/telemetry.ex", "lib/:lib_web_name/telemetry.ex"},
      {:eex, "phx_single/lib/app_name_web.ex", "lib/:lib_web_name.ex"},
      {:eex, "phx_single/mix.exs", "mix.exs"},
      {:eex, "phx_single/README.md", "README.md"},
      {:eex, "phx_single/formatter.exs", ".formatter.exs"},
      {:eex, "phx_single/gitignore", ".gitignore"},
      {:eex, "phx_test/support/conn_case.ex", "test/support/conn_case.ex"},
      {:eex, "phx_single/test/test_helper.exs", "test/test_helper.exs"},
      {:keep, "phx_test/controllers", "test/:lib_web_name/controllers"},
      {:eex, "phx_test/views/error_view_test.exs", "test/:lib_web_name/views/error_view_test.exs"}
    ],
    gettext: [
      {:eex, "phx_gettext/gettext.ex", "lib/:lib_web_name/gettext.ex"},
      {:eex, "phx_gettext/en/LC_MESSAGES/errors.po", "priv/gettext/en/LC_MESSAGES/errors.po"},
      {:eex, "phx_gettext/errors.pot", "priv/gettext/errors.pot"}
    ],
    html: [
      {:eex, "phx_web/controllers/page_controller.ex",
       "lib/:lib_web_name/controllers/page_controller.ex"},
      {:eex, "phx_web/views/page_view.ex", "lib/:lib_web_name/views/page_view.ex"},
      {:eex, "phx_test/controllers/page_controller_test.exs",
       "test/:lib_web_name/controllers/page_controller_test.exs"},
      {:eex, "phx_test/views/page_view_test.exs", "test/:lib_web_name/views/page_view_test.exs"},
      {:eex, "phx_live/assets/topbar.js", "assets/vendor/topbar.js"},
      {:eex, "phx_web/templates/layout/root.html.heex",
       "lib/:lib_web_name/templates/layout/root.html.heex"},
      {:eex, "phx_web/templates/layout/app.html.heex",
       "lib/:lib_web_name/templates/layout/app.html.heex"},
      {:eex, "phx_web/templates/layout/live.html.heex",
       "lib/:lib_web_name/templates/layout/live.html.heex"},
      {:eex, "phx_web/views/layout_view.ex", "lib/:lib_web_name/views/layout_view.ex"},
      {:eex, "phx_web/templates/page/index.html.heex",
       "lib/:lib_web_name/templates/page/index.html.heex"},
      {:eex, "phx_test/views/layout_view_test.exs",
       "test/:lib_web_name/views/layout_view_test.exs"}
    ],
    ecto: [
      {:eex, "phx_ecto/repo.ex", "lib/:app/repo.ex"},
      {:eex, "phx_ecto/schema.ex", "lib/:app/schema.ex"},
      {:keep, "phx_ecto/priv/repo/migrations", "priv/repo/migrations"},
      {:eex, "phx_ecto/setup_migration.exs", "priv/repo/migrations/00000000000000_db_setup.exs"},
      {:eex, "phx_ecto/formatter.exs", "priv/repo/migrations/.formatter.exs"},
      {:eex, "phx_ecto/seeds.exs", "priv/repo/seeds.exs"},
      {:eex, "phx_ecto/data_case.ex", "test/support/data_case.ex"}
    ],
    assets: [
      {:eex, "phx_static/phoenix.css", "assets/css/phoenix.css"},
      {:eex, "phx_assets/app.css", "assets/css/app.css"},
      {:eex, "phx_assets/app.js", "assets/js/app.js"},
      {:keep, "phx_assets/vendor", :web, "assets/vendor"}
    ],
    static: [
      {:text, "phx_static/robots.txt", "priv/static/robots.txt"},
      {:text, "phx_static/phoenix.png", "priv/static/images/phoenix.png"},
      {:text, "phx_static/favicon.ico", "priv/static/favicon.ico"}
    ],
    mailer: [
      {:eex, "phx_mailer/lib/app_name/mailer.ex", "lib/:app/mailer.ex"}
    ]
  ]

  @impl true
  def generate(%Project{} = project) do
    copy_files(project, @templates[:new])
    copy_files(project, @templates[:gettext])
    copy_files(project, @templates[:html])
    copy_files(project, @templates[:ecto])
    copy_files(project, @templates[:assets])
    copy_files(project, @templates[:static])
    copy_files(project, @templates[:mailer])
  end
end
