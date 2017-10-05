defmodule Discuss.Comments do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  import Ecto

  alias Discuss.Repo
  alias Discuss.Comments.Comment

  def add_comment(topic, content) do
    topic
    |> build_assoc(:comments)
    |> Comment.changeset(%{content: content})
    |> Repo.insert()
  end
end
