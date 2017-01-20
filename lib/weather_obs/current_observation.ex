defmodule WeatherObs.CurrentObservation do
  @display_columns [:station, :location, :weather, :temperature]

  alias WeatherObs.CurrentObservation.Fetcher, as: Fetcher
  alias WeatherObs.CurrentObservation.Parser, as: Parser

  def run(station_id) do
    Fetcher.fetch(station_id) |> decode_response
  end

  def display_columns, do: @display_columns

  def decode_response({:ok, body}), do: Parser.parse(body)

  def decode_response({:error, %{message: message}}) do
    IO.puts "Error fetching from source: #{message}"
    System.halt(2)
  end

  def output_result(list_data) do
    Enum.each(list_data, fn x -> IO.inspect(x) end)
  end
end
