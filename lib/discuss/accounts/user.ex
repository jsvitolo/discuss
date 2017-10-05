defmodule Discuss.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.Accounts.User
  alias Discuss.Topics.Topic
  alias Discuss.Comments.Comment

  @derive {Poison.Encoder, only: [:email]}

  schema "users" do
    field :email
    field :provider
    field :token
    has_many :topics, Topic
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
