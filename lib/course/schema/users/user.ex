defmodule Course.Schema.User do
  @moduledoc false

  alias Course.Schema.Message

  import Ecto.Changeset

  use Ecto.Schema

  @derive {Inspect, except: [:password]}
  schema "users" do
    field :nickname, :string
    field :email, :string
    field :age, :integer
    field :hashed_password, :string, redact: true
    field :password, :string, virtual: true

    has_many(:messages, Message)

    timestamps()
  end

  @optional [
    :age
  ]

  @required [
    :nickname,
    :email,
    :password
  ]

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @optional ++ @required)
    |> validate_required(@required)
    |> validate_format(:email, ~r/@/)
    |> hash_password()
  end

  # ---------------------------------------------
  #                    PRIVATE
  # ---------------------------------------------
  defp hash_password(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset

      pass ->
    hashed_password = Base.encode64(pass)
    put_change(changeset, :hashed_password, hashed_password)
    end
  end
end
