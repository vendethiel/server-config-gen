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
    ext = String.lstrip(Path.extname(file_name), ?.)

    try do
      {:ok, content} = File.read(file_path)
      {:ok, vars} = Parser.parse(ext, content)
      IO.puts "config parsed..."
      {:ok, generated_content} = Generator.generate(vars)
      IO.puts "content generated... writing"
      :ok = File.write("generated/#{file_name}.generated", generated_content)
    rescue
      e in MatchError ->
        #IO.write("Erreur: #{Exception.message(e)}")
        IO.puts("Error parsing #{file_name}: #{Exception.format_banner(:error, e, System.stacktrace)}")
    end
  end
end
