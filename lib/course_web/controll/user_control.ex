defmodule CourseWeb.UserController do
  @moduledoc false

  alias Course.Schema.{
    User,
    Users
  }

  require Logger

  use CourseWeb, :controller

  def logout(conn, _) do
    conn
    |> configure_session(renew: true)
    |> configure_session(drop: true)
    |> clear_session()
    |> put_flash(:info, "Successfully logged out")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def signup_form(conn, _) do
    changeset =
      User.changeset(%User{})

    conn
    |> assign(:changeset, changeset)
    |> render("signup.html")
  end

  def signup(conn, %{"user" => %{
    "password" => password,
    "confirmed_password" => confirmed_password
  } = params}) do
    with {:ok, _} <- check_confirmed_password(password, confirmed_password),
         {:ok, user} <- Users.insert(params) do

      conn
      |> put_flash(:info, "Successfully signed up")
      |> put_session(:user_id, user.id)
      |> assign(:current_user, user)
      |> redirect(to: Routes.page_path(conn, :index))
    else
      {:error, msg} ->
        Logger.error("User sign up failed with reason: #{inspect(msg)}")
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def login_form(conn, _) do
    changeset =
      User.changeset(%User{})

    conn
    |> assign(:changeset, changeset)
    |> render("login.html")

  end

  def login(conn, %{"user" => %{
    "email" => email,
    "password" => password
  }}) do
    with {:ok, user} <- Users.get_by_email(email),
         {:ok, _} <- is_pass_valid(user, password) do

      conn
      |> put_flash(:info, "Successfully logged in")
      |> put_session(:user_id, user.id)
      |> assign(:current_user, user)
      |> redirect(to: "/messaging")
    else
      {:error, msg} ->
        Logger.error("User sign up failed with reason: #{inspect(msg)}")
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: Routes.page_path(conn, :index))
    end

  end

  # ---------------------------------------------
  #                    PRIVATE
  # ---------------------------------------------

  defp check_confirmed_password(pass, pass), do: {:ok, pass}
  defp check_confirmed_password(_, _), do: {:error, "Password don't match"}

  defp is_pass_valid(%{hashed_password: hp}, password) do
    IO.inspect(hp, label: Hp)
    {:ok, decoded_pass} = Base.decode64(hp)
    if decoded_pass == password,
      do: {:ok, nil},
      else: {:error, "password does not match"}
  end
end
