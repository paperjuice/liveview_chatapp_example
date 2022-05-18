defmodule CourseWeb.Plugs.CheckAuth do
  @moduledoc false

  alias CourseWeb.Router.Helpers, as: Routes

  import Plug.Conn
  import Phoenix.Controller

  def init(opts) do
  end

  def call(conn, _) do
    case conn.assigns[:current_user] do
      nil ->
        conn
        |> redirect(to: Helpers.page_path(conn, :index))
        |> halt()

      _ -> conn
    end
  end
end

