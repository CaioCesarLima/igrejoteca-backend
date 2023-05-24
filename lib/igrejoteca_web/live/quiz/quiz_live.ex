defmodule IgrejotecaWeb.QuizLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, message: "Estamos enfrentando algum problema")}
  end
end
