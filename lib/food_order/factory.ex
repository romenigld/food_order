defmodule FoodOrder.Factory do
  use ExMachina.Ecto, repo: FoodOrder.Repo
  alias FoodOrder.Products.Product

  def product_factory do
    %Product{
      description: Faker.Food.description(),
      name: Faker.Food.dish(),
      price: Faker.Random.Elixir.random_between(1, 200),
      size: "small"
    }
  end
end
