defmodule FoodOrder.ProductFixtures do
  alias FoodOrder.Products

  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: Faker.Food.description(),
        name: Faker.Food.dish(),
        price: Faker.Random.Elixir.random_between(1, 200),
        size: "small"
      })
      |> Products.create_product()

    product
  end
end
