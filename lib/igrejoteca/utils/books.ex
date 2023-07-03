defmodule Igrejoteca.Utils.BooksApi do

  @doc false


  def book_fetch(isbn) do

    url = "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}&key=AIzaSyCiYLfidNGAEV_BwDBMDstNHb0STmwkLDo"

    # headers = [{"Content-type", "application/json"}, {"Authorization", "key=AAAAa1tsGck:APA91bHgb_kYg-CDptuzI1-JBtfI3TDMdgEtXyi2pX7Yf0UeMjBNGHj_MDVzAYyUWasPZED_Yf5SyouZ7_z4S5TsPDMgA7EpDY1r_rjWf2W2OWpOZbeh0EJKS8vFyO8JJ1cUt4yxzjck"}]


    case HTTPoison.get(url, [], []) do
      {:ok, %{status_code: 200, body: body}} ->
        IO.puts(Map.has_key?(Jason.decode!(body), "items"))
        case Map.has_key?(Jason.decode!(body), "items") do
          true -> {:ok, Jason.decode!(body)["items"] |> List.first() |> format_book()}
          false -> {:error, "Livro não encontrado"}
        end

    end
  end

  def format_book(body) do


    %{
      "title" => body["volumeInfo"]["title"],
      "subtitle"=> body["volumeInfo"]["subtitle"],
      "autor"=> body["volumeInfo"]["authors"] |> List.first(),
      "pages"=> body["volumeInfo"]["pageCount"] |> Integer.to_string(),
      "category"=> body["volumeInfo"]["categories"] |> List.first(),
    }
  end
end
