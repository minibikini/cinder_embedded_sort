defmodule CinderEmbeddedSortWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use CinderEmbeddedSortWeb, :html

  embed_templates "page_html/*"
end
