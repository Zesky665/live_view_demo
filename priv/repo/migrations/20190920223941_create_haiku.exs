defmodule LiveViewDemo.Repo.Migrations.CreateHaiku do
  use Ecto.Migration

  def change do
    create table(:haiku) do
      add :line_one, :string
      add :line_two, :string
      add :line_three, :string
      add :author, :string

      timestamps()
    end

  end
end
