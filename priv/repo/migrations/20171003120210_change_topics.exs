defmodule Discuss.Repo.Migrations.ChangeTopics do
  use Ecto.Migration

  def change do

    rename table(:topics), :tittle, to: :title

  end
end
