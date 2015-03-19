defmodule ServerConfigGen.Generator do
  require ADT
  ADT.define eex_template(variables: %{}) | yield_template(text: "")

  @templates %{
    "apache": "eex",
    "yield": "txt",
  }

  def generate(config) do
    ext = renderer_of(config[:kind])
    try do
      {:ok, content} = File.read("templates/#{config[:kind]}.#{ext}")
      {:ok, TemplateRenderer.render(template_for(ext, config), content)}
    rescue
      e -> {:error, e}
    end
  end

  defp renderer_of(template), do: Dict.fetch!(@templates, String.to_atom(template))

  defp template_for("eex", config), do: %EexTemplate{variables: config}
  defp template_for("txt", %{text: text}), do: %YieldTemplate{text: text}

  # Why a protocol for this?
  # Mostly to toy around with prototypes and ADTs, really.
  # But also because it allows for helpers (like template_path_for)
  defprotocol TemplateRenderer do
    def render(t, content)
  end

  defimpl TemplateRenderer, for: EexTemplate do
    def render(t, content) do
      EEx.eval_string(content, [assigns: t.variables])
    end
  end

  defimpl TemplateRenderer, for: YieldTemplate do
    def render(t, content) do
      String.replace(content, "{{YIELD}}", t.text)
    end
  end
end
