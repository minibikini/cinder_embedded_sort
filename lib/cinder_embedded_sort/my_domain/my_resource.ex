defmodule CinderEmbeddedSort.MyDomain.MyResource do
  use Ash.Resource,
    otp_app: :cinder_embedded_sort,
    domain: CinderEmbeddedSort.MyDomain,
    data_layer: AshSqlite.DataLayer

  sqlite do
    table "my_resources"
    repo CinderEmbeddedSort.Repo
  end

  actions do
    defaults [:read, :destroy, create: [:name, :settings], update: [:name, :settings]]
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
      public? true
    end

    attribute :settings, CinderEmbeddedSort.MyDomain.MyResourceSettings do
      allow_nil? false
      public? true
    end

    timestamps()
  end
end
