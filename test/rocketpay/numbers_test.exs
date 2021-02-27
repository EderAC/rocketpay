defmodule Rocketpay.NumbersTest do
  #must have
  use ExUnit.Case

  alias Rocketpay.Numbers
  #coloca após o describe o nome da função que será testada seguida
  #de barra e a quantidade de argumentos

  describe "sum_from_file/1" do
    test "when there is a file with the given name, returns the sum of number" do
      response = Numbers.sum_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "when there is no file with the given name, returns the sum an error" do
      response = Numbers.sum_from_file("banana")

      expected_response = {:error, %{message: "Invalid file!"}}

      assert response == expected_response
    end

  end

end
