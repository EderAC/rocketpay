defmodule RocketpayWeb.AccountsControllerTest do
use RocketpayWeb.ConnCase, async: true

alias Rocketpay.{Account, User}

  describe "deposit/2" do
    #cria o setup pois precisa ter algum usuário já cadastrado na base
    setup %{conn: conn} do
      params =%{
        name: "Eder",
        password: "123456",
        nickname: "Chituito",
        email: "eder.almeida40@gmail.com",
        age: 23
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")
      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params= %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
                "account" => %{"balance" => "50.00", "id" => _id},
                "message" => "Balance changed successfully"
              } = response
    end

    test "when there are invalids params, returns an error", %{conn: conn, account_id: account_id} do
      params= %{"value" => "banana"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expect_response = %{"message" => "Invalid deposit value!"}

      assert response == expect_response
    end

  end
end
