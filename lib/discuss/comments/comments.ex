defmodule Discuss.Comments do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  import Ecto

  alias Discuss.Repo
  alias Discuss.Comments.Comment

  def add_comment(topic, content, user_id) do
    topic
    |> build_assoc(:comments, user_id: user_id)
    |> Comment.changeset(%{content: content})
    |> Repo.insert()
  end
end
