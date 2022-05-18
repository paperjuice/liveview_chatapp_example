defmodule CourseWeb.Plugs.AddCurrentUser do
  @moduledoc false

  alias Course.Schema.Users

  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        assign(conn, :current_user, nil)

      user_id ->
        user = Users.get(user_id)

        conn
        |> assign(:current_user, user)
    end
  end
end
