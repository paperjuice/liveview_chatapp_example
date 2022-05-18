defmodule Course.Schema.Messages do
  @moduledoc false

  alias Course.Repo
  alias Course.Schema.Message

  import Ecto.Query

  # ---------------------------------------------
  #                    API
  # ---------------------------------------------
  def insert(params),
    do: do_insert(params)

  def all,
    do: do_all()

  # ---------------------------------------------
  #                    PRIVATE
  # ---------------------------------------------
  def do_insert(params) do
    %Message{}
    |> Message.changeset(params)
    |> Repo.insert()
  end

  def do_all do
    Message
    |> order_by(asc: :inserted_at)
    |> preload(:user)
    |> Repo.all()
  end
end
