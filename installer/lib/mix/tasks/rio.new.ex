defmodule Mix.Tasks.Rio.New do
  @moduledoc """
  Creates a new Phoenix project.
  """
  use Mix.Task

  @version Mix.Project.config()[:version]

  @impl true
  def run([version]) when version in ~w(-v --version) do
    Mix.shell().info("Rio installer v#{@version}")
  end
end
