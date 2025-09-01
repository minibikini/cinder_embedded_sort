defmodule CinderEmbeddedSort.MyDomain.MyResourceSettings do
  use Ash.Resource,
    data_layer: :embedded

  attributes do
    attribute :a, :string do
      allow_nil? false
      public? true
    end

    attribute :b, :integer do
      allow_nil? false
      public? true
    end
  end
end
