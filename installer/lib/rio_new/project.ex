defmodule Rio.New.Project do
  alias Rio.New.Project

  defstruct app: nil,
            app_mod: nil,
            binding: nil,
            project_path: nil,
            lib_web_name: nil

  def new(project_path) do
    project_path = Path.expand(project_path)
    app = Path.basename(project_path)
    app_mod = Module.concat([Macro.camelize(app)])

    %Project{
      app: app,
      app_mod: app_mod,
      project_path: project_path,
      lib_web_name: "#{app}_web"
    }
  end
end
