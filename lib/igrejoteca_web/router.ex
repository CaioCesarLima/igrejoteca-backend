defmodule IgrejotecaWeb.Router do
  use IgrejotecaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug IgrejotecaWeb.Middlewares.AuthenticationPlug
  end

  # scope "/api", IgrejotecaWeb do
  #   pipe_through :api

  #   resources "/prayers", PrayerController, except: [:new, :edit]
  # end
  scope "/api", IgrejotecaWeb do
    pipe_through [:api, :authenticate]

    resources "/prayer", PrayerController, except: [:new, :edit]
    post "/prayers/like", PrayerController, :add_user
    delete "/prayers/like", PrayerController, :remove_user
    get "/prayers/like", PrayerController, :list_prayers_user

    resources "/testimonials", TestimonyController, except: [:new, :edit]

    resources "/books", BookController, except: [:new, :edit]
    post "/isbn-book", BookController, :isbn_book
    get "/search-books", BookController, :search_books

    post "/reserves", BookController, :create_reserve
    delete "/reserves", BookController, :remove_reserve
    get "/reserves", BookController, :list_reserves
    get "/reserve-user", BookController, :user_reserves

    post "/loans", BookController, :create_loan
    get "/loans", BookController, :list_loans
    delete "/loans/:loan_id", BookController, :return_loan
    get "/loan-user", BookController, :user_loans

    resources "/desires", DesireController, except: [:new, :edit]

    resources "/questions", QuestionController, except: [:new, :edit]
    put "/question/correct", UserController, :incremment_score
    resources "/answers", AnswerController, except: [:new, :edit]

    resources "/clubs", ClubController, except: [:new, :edit]
  end

  scope "/auth", IgrejotecaWeb do
    pipe_through :api

    post "/login", AuthController, :login
    post "/signup", AuthController, :signup
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: IgrejotecaWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
