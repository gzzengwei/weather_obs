defmodule WeatherObs.StationImporter do
  @moduledoc """
  import xml from
  http://www.weather.gov/xml/current_obs/index.xml

  information:
  http://forecast.weather.gov/stations.php
  """

  import SweetXml
  @xml_root "//wx_station_index"
  @xml_node "./station"
  @output_file "stations.ex"

  def run(source_file) do
    {:ok, xml_str} = File.read(source_file)
    xml_str
      |> parse_xml
      |> parse_nodes
      |> process_nodes
      |> output_result
  end

  def parse_xml(xml_str) do
    xml_str |> SweetXml.xpath(~x"#{@xml_root}")
  end

  def parse_nodes(xml) do
    xml |> SweetXml.xpath(~x"#{@xml_node}"l)
  end

  def process_nodes(nodes) do
    nodes |> Enum.map(&process_node/1)
  end

  def process_node(node) do
    %{
      state: process_field(node, "state"),
      station_id: process_field(node, "station_id"),
      station_name: process_field(node, "station_name")
    }
  end

  def process_field(node, field) do
    node |> xpath(~x"./#{field}/text()"l) |> List.first |> to_string
  end

  def output_result(nodes) do
    nodes |> write_text("")
  end

  def write_text(list, text \\ "")

  def write_text([], text) do
    File.write(@output_file, text)
  end

  def write_text([head | tail], text) do
    new_text = text <> """
    %{ state: "#{head[:state]}", station_id: "#{head[:station_id]}", station_name: "#{head[:station_name]}" },
    """
    write_text(tail, new_text)
  end
end
