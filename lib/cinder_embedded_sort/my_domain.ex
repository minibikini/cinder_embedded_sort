defmodule CinderEmbeddedSort.MyDomain do
  use Ash.Domain,
    otp_app: :cinder_embedded_sort

  resources do
    resource CinderEmbeddedSort.MyDomain.MyResource
  end
end
