defmodule Discuss.Topics.Topic do
 use Ecto.Schema
 import Ecto.Changeset

 alias Discuss.Topics.Topic
 alias Discuss.Accounts.User
 alias Discuss.Comments.Comment

 schema "topics" do
   field :title
   belongs_to :user, User
   has_many :comments, Comment
 end

 @doc false
 def changeset(%Topic{} = topic, attrs) do
   topic
   |> cast(attrs, [:title])
   |> validate_required([:title])
 end
end
