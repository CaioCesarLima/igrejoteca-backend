defmodule IgrejotecaWeb.AuthView do
    use IgrejotecaWeb, :view
    alias IgrejotecaWeb.AuthView

    def render("login.json", %{auth: data}) do
      IO.inspect(data)
        render_one(data, AuthView, "auth.json")
    end
    def render("signup.json", %{auth: data}) do
      IO.inspect(data)
        render_one(data, AuthView, "auth_signup.json")
    end
    def render("auth.json",%{auth: %{token: token, user: user}}) do
      %{
        token: token,
        user: %{
            id: user.id,
            name: user.name,
            email: user.email,
            score_quiz: user.score.score
        }
      }
    end

    def render("auth_signup.json",%{auth: %{token: token, user: user}}) do
      %{
        token: token,
        user: %{
            id: user.id,
            name: user.name,
            email: user.email,
            score_quiz: user.score
        }
      }
    end
  end
