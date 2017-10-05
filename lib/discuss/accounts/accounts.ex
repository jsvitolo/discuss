defmodule Discuss.Accounts do
  import Ecto.Query,warn: false

  alias Discuss.Repo
  alias Discuss.Accounts.User


  def change_user(%User{} = user, changeset) do
    User.changeset(user, changeset)
  end

  def insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end
