defmodule Mix.Tasks.Rio.New do
  @moduledoc """
  Creates a new Phoenix project.
  """
  use Mix.Task

  alias Rio.New.Generator

  @version Mix.Project.config()[:version]

  @impl true
  def run([version]) when version in ~w(-v --version) do
    Mix.shell().info("Rio installer v#{@version}")
  end

  def run([base_path] = _argv) do
    base_path
    |> Generator.new()
    |> Generator.generate()
  end
end
