defmodule ServerConfigGen.ErrManager do
  def nil_assert(nil) do
    raise ArgumentError, "Nil assert failed" 
  end
  def nil_assert(var), do: var

  def try_wrap(f) do
    try do
      {:ok, f.()}
    rescue e ->
      {:error, e}
    end
  end
end
