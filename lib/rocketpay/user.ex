defmodule Rocketpay.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset



  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :age, :email, :password, :nickname]

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :nickname, :string

    timestamps()
  end

  #Valida e mapeia dados
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params) #faz o casting, logo se passar string no lugar de int ele transforma
    |> validate_required(@required_params) # valida que os campos obrigatórios
    |> validate_length(:password, min: 6) #valida minimo de 6 char
    |> validate_number(:age, greater_than_or_equal_to: 18) #valida idade maior ou igual a 18
    |> validate_format(:email, ~r/@/) #valida regex, que deve conter @
    |> unique_constraint([:email]) #valida que o email deve ser unico
    |> unique_constraint([:nickname]) #valida que o apelido deve ser unico
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
