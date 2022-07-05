defmodule FoodOrder.ProductsTest do
  use FoodOrder.DataCase
  alias FoodOrder.Products
  alias FoodOrder.Products.Product

  test "list_products" do
    assert Products.list_products() == []
  end

  test "get!/1" do
    payload = %{
      name: "water",
      size: "small",
      price: 100,
      description: "water 1l"
    }

    {:ok, product} = Products.create_product(payload)
    assert Products.get!(product.id).name == product.name
  end

  test "create product" do
    payload = %{
      name: "water",
      size: "small",
      price: 100,
      description: "water 1l"
    }

    assert {:ok, product} = Products.create_product(payload)

    assert {:ok, %Product{} = update_product} =
             Products.update_product(product, %{name: "abobora"})

    assert update_product.name == "abobora"
    assert update_product.price == %Money{amount: 100, currency: :BRL}
    assert update_product.size == payload.size
    assert update_product.description == payload.description
  end

  test "update product" do
    payload = %{
      name: "water",
      size: "small",
      price: 100,
      description: "water 1l"
    }

    assert {:ok, %Product{} = product} = Products.create_product(payload)

    assert product.name == payload.name
    assert product.price == %Money{amount: 100, currency: :BRL}
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
