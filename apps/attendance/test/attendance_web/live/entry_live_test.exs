defmodule AttendanceWeb.EntryLiveTest do
  use AttendanceWeb.ConnCase

  import Phoenix.LiveViewTest
  import Attendance.EntriesFixtures

  @create_attrs %{name: "some name", to: "2026-02-24T22:00:00", from: "2026-02-24T22:00:00"}
  @update_attrs %{name: "some updated name", to: "2026-02-25T22:00:00", from: "2026-02-25T22:00:00"}
  @invalid_attrs %{name: nil, to: nil, from: nil}
  defp create_entry(_) do
    entry = entry_fixture()

    %{entry: entry}
  end

  describe "Index" do
    setup [:create_entry]

    test "lists all entry", %{conn: conn, entry: entry} do
      {:ok, _index_live, html} = live(conn, ~p"/entry")

      assert html =~ "Listing Entry"
      assert html =~ entry.name
    end

    test "saves new entry", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/entry")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Entry")
               |> render_click()
               |> follow_redirect(conn, ~p"/entry/new")

      assert render(form_live) =~ "New Entry"

      assert form_live
             |> form("#entry-form", entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#entry-form", entry: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/entry")

      html = render(index_live)
      assert html =~ "Entry created successfully"
      assert html =~ "some name"
    end

    test "updates entry in listing", %{conn: conn, entry: entry} do
      {:ok, index_live, _html} = live(conn, ~p"/entry")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#entry_collection-#{entry.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/entry/#{entry}/edit")

      assert render(form_live) =~ "Edit Entry"

      assert form_live
             |> form("#entry-form", entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#entry-form", entry: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/entry")

      html = render(index_live)
      assert html =~ "Entry updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes entry in listing", %{conn: conn, entry: entry} do
      {:ok, index_live, _html} = live(conn, ~p"/entry")

      assert index_live |> element("#entry_collection-#{entry.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#entry-#{entry.id}")
    end
  end

  describe "Show" do
    setup [:create_entry]

    test "displays entry", %{conn: conn, entry: entry} do
      {:ok, _show_live, html} = live(conn, ~p"/entry/#{entry}")

      assert html =~ "Show Entry"
      assert html =~ entry.name
    end

    test "updates entry and returns to show", %{conn: conn, entry: entry} do
      {:ok, show_live, _html} = live(conn, ~p"/entry/#{entry}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/entry/#{entry}/edit?return_to=show")

      assert render(form_live) =~ "Edit Entry"

      assert form_live
             |> form("#entry-form", entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#entry-form", entry: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/entry/#{entry}")

      html = render(show_live)
      assert html =~ "Entry updated successfully"
      assert html =~ "some updated name"
    end
  end
end
