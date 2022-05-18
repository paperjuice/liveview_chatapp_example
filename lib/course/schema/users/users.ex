defmodule Course.Schema.Users do
  @moduledoc false

  alias Course.Repo
  alias Course.Schema.User

  import Ecto.Query

  # ---------------------------------------------
  #                    API
  # ---------------------------------------------
  def insert(params),
    do: do_insert(params)

  def all,
    do: do_all()

  def get(user_id),
    do: do_get(user_id)

  def get_by_email(email),
    do: do_get_by_email(email)

  # ---------------------------------------------
  #                    PRIVATE
  # ---------------------------------------------
  def do_get_by_email(email) do
    query = from(u in User, where: u.email == ^email)
    case Repo.one(query) do
      nil -> {:error, "no user found"}
      user ->{:ok, user}
    end
  end

  def do_insert(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()

  end

  def do_all do
    Repo.all(User)
  end

  def do_get(user_id) do
    Repo.get(User, user_id)
  end
end
