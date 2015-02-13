defmodule ServerConfigGen.Generator do
  alias ServerConfigGen.ErrManager, as: Err

  # TODO only take config
  def generate({:ok, config}) do
    IO.puts inspect(config)
    
    try do
      {:ok, EEx.eval_file(template_path_for(config[:kind]), [assigns: config])}
    rescue
        e -> {:error, e}
    end
  end

  defp template_path_for(kind) when is_binary(kind) do
    "templates/#{kind}.eex"
  end
end
