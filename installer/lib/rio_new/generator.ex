defmodule Rio.New.Generator do
  alias Rio.New.Project

  defmacro __using__(_env) do
    quote do
      @behaviour unquote(__MODULE__)
      import Rio.New.Generator
    end
  end

  @callback generate(Project.t()) :: Project.t()

  @apps [:rio_new, :phx_new]
  @phoenix_version Version.parse!("1.6.10")

  def copy_files(%Project{} = project, templates) do
    roots = Enum.map(@apps, &to_app_source/1)

    for {format, source_path, target_path} <- templates do
      target = join_path(project, target_path)

      case format do
        :eex ->
          source = template_path(source_path, roots)
          Mix.Generator.copy_template(source, target, project.binding)

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

  defp join_path(%Project{} = project, path) do
    project
    |> Map.fetch!(:project_path)
    |> Path.join(path)
    |> expand_path_with_bindings(project)
  end

  defp expand_path_with_bindings(path, %Project{} = project) do
    Regex.replace(~r/:[a-zA-Z0-9_]+/, path, fn ":" <> key, _ ->
      project |> Map.fetch!(:"#{key}") |> to_string()
    end)
  end

  def put_binding(%Project{} = project) do
    version = @phoenix_version
    web_namespace = Module.concat(["#{project.app_mod}Web"])

    # We lowercase the database name because according to the
    # SQL spec, they are case insensitive unless quoted, which
    # means creating a database like FoO is the same as foo in
    # some storages.
    {adapter_app, adapter_module, adapter_config} =
      get_ecto_adapter("postgres", String.downcase(project.app), project.app_mod)

    binding = [
      assets: true,
      dashboard: true,
      ecto: true,
      gettext: true,
      html: true,
      live: true,
      mailer: true,
      app_module: inspect(project.app_mod),
      app_name: project.app,
      signing_salt: random_string(8),
      lv_signing_salt: random_string(8),
      secret_key_base_dev: random_string(64),
      secret_key_base_test: random_string(64),
      phoenix_dep: phoenix_dep(),
      phoenix_js_path: "phoenix",
      phoenix_github_version_tag: "v#{version.major}.#{version.minor}",
      in_umbrella: false,
      endpoint_module: inspect(Module.concat(web_namespace, Endpoint)),
      lib_web_name: project.lib_web_name,
      web_app_name: project.app,
      web_namespace: inspect(web_namespace),
      live_comment: nil,
      adapter_app: adapter_app,
      adapter_module: adapter_module,
      adapter_config: adapter_config
    ]

    %Project{project | binding: binding}
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
