defmodule ServerConfigGen.TryOrError do
  def wrap(f) do
    try do
      {:ok, f.()}
    rescue e ->
      {:error, e}
    end
  end
end
