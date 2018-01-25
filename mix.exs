defmodule CaptacionAgua.Mixfile do
  use Mix.Project

  def aliases do
    [
      "ensure_consistency": [ "test", "dialyzer", "credo --strict", "inch", "coveralls"]
    ]
  end

  def project do
    [
      app: :captacion_agua,
      aliases: aliases(),
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      dialyzer: [ plt_add_deps: :transitive ],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
      ],
      test_coverage: [ tool: ExCoveralls ],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:credo, "~> 0.8.10", only: [:dev], runtime: false},
      {:dialyxir, "~> 0.5.1", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.18.1", only: [:dev], runtime: false},
      {:inch_ex, "~> 0.5.6", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.8.0", only: [:dev], runtime: false},
      {:download, path: "../../download"},
    ]
  end
end
