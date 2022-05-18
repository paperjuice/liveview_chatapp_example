defmodule Course.Repo do
  use Ecto.Repo,
    otp_app: :course,
    adapter: Ecto.Adapters.Postgres
end
