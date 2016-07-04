defmodule Gardex.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi"

  def project do
    [app: :gardex,
     version: "0.1.0",
     elixir: "~> 1.3",
     archives: [nerves_bootstrap: "~> 0.1.3"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     target: @target,
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  def application do
    [mod: {Gardex, []},
     applications: [:logger, :nerves_leds, :elixir_ale]]
  end

  defp deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_leds, "~> 0.7.0"},
     {:elixir_ale, "~> 0.5.5"}]
  end

  def system(target) do
    [
     {:"nerves_system_#{target}", "~> 0.6.0"}
    ]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths",    "nerves.loadpaths"],
     "deploy":          ["compile", "firmware", "firmware.burn"]]
  end
end
