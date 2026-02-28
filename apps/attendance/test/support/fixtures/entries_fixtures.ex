defmodule Attendance.EntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Attendance.Entries` context.
  """

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{
        from: ~N[2026-02-24 22:00:00],
        name: "some name",
        to: ~N[2026-02-24 22:00:00]
      })
      |> Attendance.Entries.create_entry()

    entry
  end
end
