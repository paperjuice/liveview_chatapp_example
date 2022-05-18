defmodule Course.Schema.UserTest do
  @moduledoc false

  alias Course.Schema.Users

  use Course.DataCase

  describe "happy path" do
    test "successfully retreive inserted user" do
      email = "email@email.com"

      params = %{
        nickname: "Rob",
        email: email,
        password: "some_pass"
      }

      Users.insert(params)
      {:ok, actual_user} = Users.get_by_email(email)

      assert actual_user.nickname == "Rob"
    end
  end
end
