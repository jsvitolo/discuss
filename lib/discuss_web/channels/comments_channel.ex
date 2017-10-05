defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.{Comments, Topics}

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Topics.get_topic!(topic_id)

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket)  do
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    case Comments.add_comment(topic, content, user_id)do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}
      {:error, reason} ->
        {:reply, {:error, %{errors: reason}}, socket}
    end
  end
end
