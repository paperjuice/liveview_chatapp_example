defmodule Course do

  def example_one do
    a = [2]
    b = "hello"

    if a != [] do
      [item|_] = a
      if item == 1 do
        if b == "hello" do
          {:ok, "everything checks"}
        else
          {:error, "b is not what I expected"}
        end
      else
        {:error, "the list has weird value"}
      end
    else
      {:error, "a is empty list"}
    end
  end

  def example_two do
    a = [1]
    b = "hello"

    with {:ok, hd} <- maybe_has_value(a),
         {:ok, _} <- maybe_one(hd),
         {:ok, msg} <- maybe_hello(b) do
      msg
    else
      {:error, reason} ->
        reason
    end
  end

  def example_three(%{}) do
    "empty map"
  end

  def example_three(a) when a == %{} do
    "is empty map"
  end

  def example_three(_a) do
    "not empty map"
  end

  def temp do
    hello = "foo"

    case "bar" do
      ^hello -> "ok"
      "bar" -> "the other foo"
    end
  end

  defp maybe_has_value([]), do: {:error, "a is empty_list"}

  defp maybe_has_value([hd|_tl]), do: {:ok, hd}

  defp maybe_one(1), do: {:ok, nil}

  defp maybe_one(_), do: {:error, "the list has a weird value"}

  defp maybe_hello("hello"), do: {:ok, "everything checks"}

  defp maybe_hello(_), do: {:error, "not what I expected"}
end
