defmodule FoodOrder.ProductsTest do
  use FoodOrder.DataCase
  alias FoodOrder.Products
  alias FoodOrder.Products.Product

  test "list_products" do
    assert Products.list_products() == []
  end

  test "create product" do
    payload = %{name: "water", size: "small", price: 5, description: "water 1l"}

    assert {:ok, %Product{} = product} = Products.create_product(payload)

    assert product.name == payload.name
    assert product.price == payload.price
    assert product.price == payload.price
    assert product.size == payload.size
    assert product.description == payload.description
  end
end