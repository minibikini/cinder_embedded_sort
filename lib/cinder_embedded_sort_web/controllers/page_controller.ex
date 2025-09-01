defmodule CinderEmbeddedSortWeb.PageController do
  use CinderEmbeddedSortWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
