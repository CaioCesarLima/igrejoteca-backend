defmodule IgrejotecaWeb.Utils.Translate do
  @translations %{
    "en" => %{
      "has invalid format" => "has an invalid format",
      # Outros mapeamentos de erro
    },
    "pt" => %{
      "email" => %{
        "has invalid format" => "possui um formato inválido",
      }
      # Outros mapeamentos de erro para português
    }
  }

  def translate_error(error_message, locale \\ "en") do
    IO.inspect(error_message, label: "error message")
    case Map.fetch!(@translations, locale) do
      %{^error_message=> translations} ->
        translations
      erro ->
        error_message
    end
  end
end
