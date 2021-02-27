defmodule Rocketpay.Account do
  use Ecto.Schema

  import Ecto.Changeset

  alias Rocketpay.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:balance, :user_id]

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  #struct \\ %__MODULE__{}, significa que o changeset de update não começa com uma struct vazia
  def changeset(struct \\  %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params) #faz o casting, logo se passar string no lugar de int ele transforma
    |> validate_required(@required_params) # valida que os campos obrigatórios
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end
end
