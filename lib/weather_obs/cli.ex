defmodule WeatherObs.CLI do
  import WeatherObs.TableFormatter, only: [ print_table_for_columns: 2 ]

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases: [h: :help])

    case parse do
      { [help: true], _, _ } -> :help
      {  _, ["current", station_id], _ } -> { :current, station_id }
      {  _, ["states"], _ } -> :states
      {  _, ["stations", state], _ } -> { :stations, state }
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts "in help"
    IO.puts """
    usage: weather_obs <command> [<station_id>]

    command list:
      current: get current observation
        ### Example: weather_obs current KDTO
      states: list states
        ### Example: weather_obs states
      stations: list stations of state
        ### Example: weather_obs stations AB
    """
    System.halt(0)
  end

  def process(:states) do
    WeatherObs.Stations.states_by_chunk
      |> Enum.map(fn(list) -> Enum.join(list, ", ") end)
      |> Enum.each(&IO.puts/1)
  end

  def process({:current, station_id}) do
    WeatherObs.CurrentObservation.run(station_id)
      |> print_table_for_columns(WeatherObs.CurrentObservation.display_columns)
  end

  def process({:stations, state}) do
    WeatherObs.Stations.stations_of_state(state)
      |> print_table_for_columns([:state, :station_id, :station_name])
  end
end
