defmodule ServerConfigGen.Generator do
  def generate(config) do
    IO.inspect "config", config

    case File.read("templates/#{config[:kind]}") do
      {:ok, content} ->
        {:ok, EEx.eval_string(content, config)}
      {:error, err} ->
        {:error, "Unable to read template file for #{config[:kind]} (#{err})"}
    end
  end
end
