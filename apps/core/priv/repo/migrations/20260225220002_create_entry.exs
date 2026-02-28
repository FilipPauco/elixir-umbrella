defmodule Core3.Repo.Migrations.CreateEntry do
  use Ecto.Migration

  def change do
    create table(:entry) do
      add(:name, :string)
      add(:from, :naive_datetime)
      add(:to, :naive_datetime)

      timestamps(type: :utc_datetime)
    end
  end
end
