defmodule CourseWeb.MessagingLive do
  @moduledoc false

  alias Course.Schema.{
    Messages,
    Users
  }
  alias CourseWeb.MessagingView
  alias Phoenix.View
  alias Phoenix.PubSub

  use Phoenix.LiveView


  def render(assigns) do
    View.render(MessagingView, "index.html", assigns)
  end






  def mount(_, %{"email" => email}, socket) do
  end









  def mount(_, %{"user_id" => user_id}, socket) do
    user = Users.get(user_id)
    messages = Messages.all()



    messages = []




    PubSub.subscribe(Course.PubSub, "room1")

    new_socket =
      socket
      |> assign(:user_name, user.nickname)
      |> assign(:user_id, user.id)
      |> assign(:messages, messages)
      |> assign(:update, "")
      |> assign(:state, :init)

    {:ok, new_socket}
  end

  def handle_info({:message, new_message}, socket) do
    messages = socket.assigns.messages
    new_socket = assign(socket, messages ++ [new_message])

    {:noreply, socket}
  end


  def handle_event("add", %{"message" => %{"input" => input}}, socket) do
    user_id = socket.assigns.user_id
    user_name = socket.assigns.user_name


    Messages.insert(%{
      content: input,
      user_id: user_id
    })

    new_message = %{
      content: input,
      user: user_name
    }

    PubSub.broadcast(
      Course.PubSub,
      "room1",
      {:message, new_message})

    {:noreply, socket}
  end
end
