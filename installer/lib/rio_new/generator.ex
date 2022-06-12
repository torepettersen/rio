defmodule Rio.New.Generator do
  alias Rio.New.Generator

  defstruct app: nil,
            app_mod: nil,
            binding: nil,
            project_path: nil,
            lib_web_name: nil

  @apps [:rio_new, :phx_new]
  @phoenix_version Version.parse!("1.6.10")
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
      {:keep, "phx_ecto/priv/repo/migrations", "priv/repo/migrations"},
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

  def new(project_path) do
    %Generator{}
    |> define_app(project_path)
    |> put_binding()
  end

  def generate(%Generator{} = generator) do
    copy_files(generator, @templates[:new])
    copy_files(generator, @templates[:gettext])
    copy_files(generator, @templates[:html])
    copy_files(generator, @templates[:ecto])
    copy_files(generator, @templates[:assets])
    copy_files(generator, @templates[:static])
    copy_files(generator, @templates[:mailer])
  end

  defp copy_files(%Generator{} = generator, templates) do
    roots = Enum.map(@apps, &to_app_source/1)

    for {format, source_path, target_path} <- templates do
      target = join_path(generator, target_path)

      case format do
        :eex ->
          source = template_path(source_path, roots)
          Mix.Generator.copy_template(source, target, generator.binding)

        :text ->
          source = template_path(source_path, roots)
          Mix.Generator.copy_file(source, target)

        :keep ->
          File.mkdir_p!(target)
      end
    end
  end

  defp to_app_source(:phx_new) do
    %{phx_new: phx_new_path} = Mix.Project.deps_paths()
    Path.join([phx_new_path, "templates"])
  end

  defp to_app_source(app) when is_atom(app),
    do: Application.app_dir(app, "priv/templates")

  defp template_path(path, roots) do
    Enum.find_value(roots, fn root ->
      source = Path.join(root, path)
      if File.exists?(source), do: source
    end) || raise "could not find #{path} in any of the sources"
  end

  defp join_path(%Generator{} = generator, path) do
    generator
    |> Map.fetch!(:project_path)
    |> Path.join(path)
    |> expand_path_with_bindings(generator)
  end

  defp expand_path_with_bindings(path, %Generator{} = generator) do
    Regex.replace(Regex.recompile!(~r/:[a-zA-Z0-9_]+/), path, fn ":" <> key, _ ->
      generator |> Map.fetch!(:"#{key}") |> to_string()
    end)
  end

  defp define_app(%Generator{} = generator, project_path) do
    project_path = Path.expand(project_path)
    app = Path.basename(project_path)
    app_mod = Module.concat([Macro.camelize(app)])

    %Generator{
      generator
      | app: app,
        app_mod: app_mod,
        project_path: project_path,
        lib_web_name: "#{app}_web"
    }
  end

  defp put_binding(%Generator{} = generator) do
    version = @phoenix_version
    web_namespace = Module.concat(["#{generator.app_mod}Web"])

    # We lowercase the database name because according to the
    # SQL spec, they are case insensitive unless quoted, which
    # means creating a database like FoO is the same as foo in
    # some storages.
    {adapter_app, adapter_module, adapter_config} =
      get_ecto_adapter("postgres", String.downcase(generator.app), generator.app_mod)

    binding = [
      assets: true,
      dashboard: true,
      ecto: true,
      gettext: true,
      html: true,
      live: true,
      mailer: true,
      app_module: inspect(generator.app_mod),
      app_name: generator.app,
      signing_salt: random_string(8),
      lv_signing_salt: random_string(8),
      secret_key_base_dev: random_string(64),
      secret_key_base_test: random_string(64),
      phoenix_dep: phoenix_dep(),
      phoenix_js_path: "phoenix",
      phoenix_github_version_tag: "v#{version.major}.#{version.minor}",
      in_umbrella: false,
      endpoint_module: inspect(Module.concat(web_namespace, Endpoint)),
      lib_web_name: generator.lib_web_name,
      web_app_name: generator.app,
      web_namespace: inspect(web_namespace),
      live_comment: nil,
      adapter_app: adapter_app,
      adapter_module: adapter_module,
      adapter_config: adapter_config
    ]

    %Generator{generator | binding: binding}
  end

  defp random_string(length),
    do: :crypto.strong_rand_bytes(length) |> Base.encode64() |> binary_part(0, length)

  defp get_ecto_adapter("postgres", app, module) do
    {:postgrex, Ecto.Adapters.Postgres, db_config(app, module, "postgres", "postgres")}
  end

  defp db_config(app, module, user, pass) do
    [
      dev: [
        username: user,
        password: pass,
        hostname: "localhost",
        database: "#{app}_dev",
        stacktrace: true,
        show_sensitive_data_on_connection_error: true,
        pool_size: 10
      ],
      test: [
        username: user,
        password: pass,
        hostname: "localhost",
        database: {:literal, ~s|"#{app}_test\#{System.get_env("MIX_TEST_PARTITION")}"|},
        pool: Ecto.Adapters.SQL.Sandbox,
        pool_size: 10
      ],
      test_setup_all: "Ecto.Adapters.SQL.Sandbox.mode(#{inspect(module)}.Repo, :manual)",
      test_setup: """
          pid = Ecto.Adapters.SQL.Sandbox.start_owner!(#{inspect(module)}.Repo, shared: not tags[:async])
          on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)\
      """,
      prod_variables: """
      database_url =
        System.get_env("DATABASE_URL") ||
          raise \"""
          environment variable DATABASE_URL is missing.
          For example: ecto://USER:PASS@HOST/DATABASE
          \"""

      maybe_ipv6 = if System.get_env("ECTO_IPV6"), do: [:inet6], else: []
      """,
      prod_config: """
      # ssl: true,
      url: database_url,
      pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
      socket_options: maybe_ipv6
      """
    ]
  end

  defp phoenix_dep,
    do: ~s[{:phoenix, "~> #{@phoenix_version}"}]
end
