for i <- 1..100 do
  Ash.Seed.seed!(CinderEmbeddedSort.MyDomain.MyResource, %{
    name: "item_#{i}",
    settings: %{
      a: "value_a_#{i}",
      b: i
    }
  })
end
