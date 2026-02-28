defmodule Attendance.Entries.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entry" do
    field :name, :string
    field :from, :naive_datetime
    field :to, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:name, :from, :to])
    |> validate_required([:name, :from, :to])
  end
end
