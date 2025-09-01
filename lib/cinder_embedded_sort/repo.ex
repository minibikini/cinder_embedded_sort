defmodule CinderEmbeddedSort.Repo do
  use AshSqlite.Repo,
    otp_app: :cinder_embedded_sort
end
