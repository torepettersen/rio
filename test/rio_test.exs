defmodule RioTest do
  use ExUnit.Case
  doctest Rio

  test "greets the world" do
    assert Rio.hello() == :world
  end
end
