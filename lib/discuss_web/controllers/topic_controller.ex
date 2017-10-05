defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Topics
  alias Discuss.Topics.Topic
  alias DiscussWeb.Plugs.RequireAuth

  plug RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    topics = Topics.list_topics()
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Topics.change_topic(%Topic{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic_params}) do
    case Topics.create_topic(conn.assigns.user, topic_params) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: topic_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Topics.get_topic!(topic_id)
    render conn, "show.html", topic: topic
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Topics.get_topic!(topic_id)
    changeset = Topics.change_topic(topic)
    render conn, "edit.html", topic: topic, changeset: changeset
  end

  def update(conn, %{"id" => topic_id, "topic" => topic_params}) do
    topic = Topics.get_topic!(topic_id)

    case Topics.update_topic(topic, topic_params) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully.")
        |> redirect(to: topic_path(conn, :index))
      {:false, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", topic: topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    topic = Topics.get_topic!(topic_id)

    {:ok, _topic} = Topics.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully")
    |> redirect(to: topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    case Topics.topic_owner(topic_id, conn.assigns.user.id) do
      {:ok, _user} ->
        conn
      {:error, _result} ->
        conn
        |> put_flash(:error, "You cannot edit that")
        |> redirect(to: topic_path(conn, :index))
    end
  end
end
