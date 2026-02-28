defmodule Attendance.EntriesTest do
  use Attendance.DataCase

  alias Attendance.Entries

  describe "entry" do
    alias Attendance.Entries.Entry

    import Attendance.EntriesFixtures

    @invalid_attrs %{name: nil, to: nil, from: nil}

    test "list_entry/0 returns all entry" do
      entry = entry_fixture()
      assert Entries.list_entry() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Entries.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      valid_attrs = %{name: "some name", to: ~N[2026-02-24 22:00:00], from: ~N[2026-02-24 22:00:00]}

      assert {:ok, %Entry{} = entry} = Entries.create_entry(valid_attrs)
      assert entry.name == "some name"
      assert entry.to == ~N[2026-02-24 22:00:00]
      assert entry.from == ~N[2026-02-24 22:00:00]
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entries.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      update_attrs = %{name: "some updated name", to: ~N[2026-02-25 22:00:00], from: ~N[2026-02-25 22:00:00]}

      assert {:ok, %Entry{} = entry} = Entries.update_entry(entry, update_attrs)
      assert entry.name == "some updated name"
      assert entry.to == ~N[2026-02-25 22:00:00]
      assert entry.from == ~N[2026-02-25 22:00:00]
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Entries.update_entry(entry, @invalid_attrs)
      assert entry == Entries.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Entries.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Entries.change_entry(entry)
    end
  end
end
