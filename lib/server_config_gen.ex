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

  def callback(file_path, events) do
    IO.puts "hey m9 " <> file_path
    IO.inspect {file_path, events}
  end
end
