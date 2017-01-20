defmodule WeatherObs.CurrentObservation.Parser do
  import SweetXml

  def parse(body) do
    body
      |> SweetXml.xpath(~x"//current_observation"l)
      |> Enum.map(&process_node/1)
  end

  defp process_node(node) do
    %{
      location: process_field(node, "location"),
      station: process_field(node, "station_id"),
      latitude: process_field(node, "latitude", :float),
      longitude: process_field(node, "longitude", :float),
      observation_time: process_field(node, "observation_time"),
      observation_time_rfc822: process_field(node, "observation_time_rfc822"),
      weather: process_field(node, "weather"),
      temperature: process_field(node, "temperature_string"),
      temp_f: process_field(node, "temp_f", :float),
      temp_c: process_field(node, "temp_c", :float),
      relative_humidity: process_field(node, "relative_humidity", :float),
      wind: process_field(node, "wind_string"),
      wind_dir: process_field(node, "wind_dir"),
      wind_degrees: process_field(node, "wind_degrees", :float),
      wind_mph: process_field(node, "wind_mph", :float),
      wind_kt: process_field(node, "wind_kt", :float),
      pressure: process_field(node, "pressure_string", :float),
      pressure_mb: process_field(node, "pressure_mb", :float),
      pressure_in: process_field(node, "pressure_in", :float),
      dewpoint: process_field(node, "dewpoint_string"),
      dewpoint_f: process_field(node, "dewpoint_f", :float),
      dewpoint_c: process_field(node, "dewpoint_c", :float),
      visibility_mi: process_field(node, "visibility_mi", :float)
    }
  end

  defp process_field(node, field, type \\ :string) do
    case type do
      :string -> process_str_field(node, field)
      :float -> process_float_field(node, field)
    end
  end

  defp process_str_field(node, field) do
    node |> xpath(~x"./#{field}/text()"l) |> List.first |> to_string
  end

  defp process_float_field(node, field) do
    process_str_field(node, field) |> Float.parse |> elem(0)
  end
end
