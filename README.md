# CaptacionAgua

Purpose of the app is to learn and practice Elixir, in this case the use of an
Agent to maintain state. This state is loaded from a text file that is download
using another app as a dependency (:download).

**TODO: Add description**

* More validations on the downloaded file.
* Maybe use stream to read the file.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `captacion_agua` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:captacion_agua, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/captacion_agua](https://hexdocs.pm/captacion_agua).
