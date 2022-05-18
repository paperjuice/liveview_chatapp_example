defmodule Course.Schema.Message do
  @moduledoc false

  alias Course.Schema.User

  import Ecto.Changeset

  use Ecto.Schema


  schema "messages" do
    field :content, :string

    belongs_to(:user, User)

    timestamps()
  end

  @required [
    :content,
    :user_id
  ]

  def changeset(message, params \\ %{}) do
    message
    |> cast(params, @required)
    |> validate_required(@required)
  end
end
