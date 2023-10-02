defmodule IgrejotecaWeb.Utils.Translate do
  @translations %{
    "en" => %{
      "has invalid format" => "has an invalid format",
      # Outros mapeamentos de erro
    },
    "pt" => %{
      "has invalid format" => "possui um formato inválido",
      # Outros mapeamentos de erro para português
    }
  }

  def translate_error(error_message, locale \\ "en") do
    case Map.fetch!(@translations, locale) do
      {_, translations} ->
        Map.get(translations, error_message, error_message)
      _ ->
        error_message
    end
  end
end
