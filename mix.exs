defmodule WeatherObs.Mixfile do
  use Mix.Project

  def project do
    [app: :weather_obs,
     version: "0.1.0",
     elixir: "~> 1.4",
     escript: escript_config(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp escript_config do
    [ main_module: WeatherObs.CLI ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11"},
      {:poison, "~> 3.0"},
      {:sweet_xml, "~> 0.6.4"},
      {:ex_doc, "~> 0.14.5"},
      {:earmark, "~> 1.0.3", override: true}
    ]
  end
end
