defmodule Discuss.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:content, :user]}

  alias Discuss.Comments.Comment
  alias Discuss.Accounts.User
  alias Discuss.Topics.Topic

  schema "comments" do
    field :content
    belongs_to :user, User
    belongs_to :topic, Topic

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
