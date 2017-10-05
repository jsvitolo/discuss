defmodule Discuss.Topics do
  import Ecto.Query, warn: false
  import Ecto.Changeset

  alias Discuss.Repo
  alias Discuss.Topics.Topic
  alias Discuss.Accounts.User

  def list_topics do
    Topic
    |> Repo.all
  end

  def create_topic(%User{} = user, attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> put_change(:user_id, user.id)
    |> Repo.insert()
  end

  def change_topic(%Topic{} = topic, attrs \\ %{}) do
    Topic.changeset(topic, attrs)
  end

  def get_topic!(id) do
    Topic
    |> Repo.get!(id)
    |> Repo.preload(comments: [:user])
  end

  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  def delete_topic(%Topic{} = topic) do
    topic
    |> Repo.delete()
  end

  def topic_owner(topic_id, user_id) do
    case Repo.get(Topic, topic_id).user_id == user_id do
      true ->
        {:ok, :user}
      false ->
        {:error, :result}
    end
  end
end
