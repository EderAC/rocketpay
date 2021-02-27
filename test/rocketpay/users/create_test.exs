defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.Users.Create
  alias Rocketpay.User

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Eder",
        password: "123456",
        nickname: "Chituito",
        email: "eder.almeida40@gmail.com",
        age: 23
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      #faz a comparação entre o usuário que acabamos de criar e os dados do banco
      assert %User{name: "Eder", age: 23, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Eder",
        nickname: "Chituito",
        email: "eder.almeida40@gmail.com",
        age: 15
      }

      # verifica se é {error, changeset}, pois definimos na criação
      # que esse é o retorno do erro
      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      #faz a comparação entre o usuário que acabamos de criar e os dados do banco
      assert errors_on(changeset) == expected_response

    end
  end
end
