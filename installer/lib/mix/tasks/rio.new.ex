defmodule Mix.Tasks.Rio.New do
  @moduledoc """
  Creates a new Phoenix project.
  """
  use Mix.Task

  alias Rio.New.Project
  alias Rio.New.Generator
  alias Rio.New.Live

  @version Mix.Project.config()[:version]

  @impl true
  def run([version]) when version in ~w(-v --version) do
    Mix.shell().info("Rio installer v#{@version}")
  end

  def run([base_path] = _argv) do
    generator = Live

    base_path
    |> Project.new()
    |> Generator.put_binding()
    |> generator.generate()
  end
end
