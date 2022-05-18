defmodule Course.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :nickname, :string
      add :age, :integer
      add :hashed_password, :string

      timestamps()
    end

      create unique_index(:users, [:email])
  end
end
