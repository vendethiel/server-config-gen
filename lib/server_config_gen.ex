defmodule ServerConfigGen do
  @moduledoc """
  Entry point for the application
  """

  use Application

  def start(_type, _args) do
    ExFSWatch.Supervisor.start_link
  end

  use ExFSWatch, dirs: ["server_config_files"]
  
  def callback(:stop) do
    IO.puts "stop pls"
  end

  def callback(file_path, _events) do
    relative_path = Path.relative_to_cwd(file_path)
    IO.puts "Parsing #{relative_path}"

    content = File.read!(file_path) |> Parser.parse |> Generator.generate
    IO.binread "#{file_path}.apache"
  end
end
