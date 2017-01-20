defmodule WeatherObs.CurrentObservation.Fetcher do
  @user_agent [ {"User-agent", "Elixir elixir@example.com"} ]
  @weather_url Application.get_env(:weather_obs, :weather_url)

  def fetch(station_id) do
    xml_url(station_id)
      |> HTTPoison.get(@user_agent)
      |> handle_response
  end

  def xml_url(station_id) do
    "#{@weather_url}/xml/current_obs/#{String.upcase(station_id)}.xml"
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    { :ok, body }
  end

  defp handle_response({:ok, %{status_code: 403, body: _}}) do
    { :error, %{ message: "Station ID not found."} }
  end

  defp handle_response({_, _}) do
    { :error, %{ message: "Unknown Errors."} }
  end
end
