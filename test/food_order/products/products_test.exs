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

  test "given a product with the same name should throw an error message" do
    payload = %{name: "water", size: "small", price: 5, description: "water 1l"}

    assert {:ok, %Product{} = _product} = Products.create_product(payload)
    assert {:error, changeset} = Products.create_product(payload)

    assert "has already been taken" in errors_on(changeset).name
    assert %{name: ["has already been taken"]} = errors_on(changeset)
  end
end
