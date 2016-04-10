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

    with {:ok, content} <- File.read(file_path),
         {:ok, vars} <- Parser.parse(ext, content),
         IO.puts("Parsed #{file_path}"),
         {:ok, generated_content} <- Generator.generate(vars),
         IO.puts("Generated #{file_path}"),
         :ok <- File.write("generated/#{file_name}.generated", generated_content)
         do
           IO.puts("Wrote #{file_name}")
         else
           IO.puts("Error: unable to configurize #{file_path}")
         end
  end
end
