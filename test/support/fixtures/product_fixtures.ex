defmodule FoodOrder.ProductFixtures do
  alias Faker.Food, as: FF
  alias Faker.Random.Elixir, as: FRE
  alias FoodOrder.Products

  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: FF.description(),
        name: FF.dish(),
        price: FRE.random_between(1, 200),
        size: "small"
      })
      |> Products.create_product()

    product
  end
end
