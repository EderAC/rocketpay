#cria uma fachada para os usuários
defmodule Rocketpay do

  alias Rocketpay.Users.Create, as: UserCreate

  defdelegate create_user(params), to: UserCreate, as: :call
end
