defmodule ServerConfigGen do
  @moduledoc """
  Entry point for the application
  """

  use Application
  use Pipe
  alias ServerConfigGen.Parser
  alias ServerConfigGen.Generator

  def start(_type, _args) do
    ExFSWatch.Supervisor.start_link
  end

  use ExFSWatch, dirs: ["server_config_files"]
  
  def callback(:stop) do
    IO.puts "stop pls"
  end

  def callback(file_path, _events) do
    IO.puts("Parsing #{Path.relative_to_cwd(file_path)}")
    file_name = Path.basename(file_path)

    write = fn
      ({:ok, content}) ->
        case File.write("generated/#{file_name}.generated", content) do
          :ok -> {:ok, ""}
          e -> e
        end
      (x) -> IO.puts ":("
    end

    case (pipe_matching {:ok, _},
    File.read(file_path)
    |> Parser.parse
    |> Generator.generate
    |> write.()) do
      {:ok, _} -> IO.puts "Okay, file generated!"
      {:error, e} ->
        IO.puts("Error parsing #{file_name}: #{Exception.format_banner(:error, e, System.stacktrace)}")
        IO.puts inspect(System.stacktrace)
    end
  end
end
