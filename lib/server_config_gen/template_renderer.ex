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
