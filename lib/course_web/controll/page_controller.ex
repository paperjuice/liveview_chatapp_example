defmodule CourseWeb.PageController do
  use CourseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
