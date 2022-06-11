# Rio
A generator for Phoenix LiveView projects.

## Installation

Add `rio` to your list of dependencies in `mix.exs`

    ```elixir
    def deps do
      [
        {:rio, "~> 0.1", only: [:dev], runtime: false}
        ...
      ]
    end
    ```

Install and compile dependencies

    $ mix do deps.get, deps.compile

