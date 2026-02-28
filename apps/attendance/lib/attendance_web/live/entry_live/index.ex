defmodule AttendanceWeb.EntryLive.Index do
  use AttendanceWeb, :live_view

  alias Attendance.Entries

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Entry
        <:actions>
          <.button variant="primary" navigate={~p"/entry/new"}>
            <.icon name="hero-plus" /> New Entry
          </.button>
        </:actions>
      </.header>

      <.table
        id="entry"
        rows={@streams.entry_collection}
        row_click={fn {_id, entry} -> JS.navigate(~p"/entry/#{entry}") end}
      >
        <:col :let={{_id, entry}} label="Name">{entry.name}</:col>
        <:col :let={{_id, entry}} label="From">{entry.from}</:col>
        <:col :let={{_id, entry}} label="To">{entry.to}</:col>
        <:action :let={{_id, entry}}>
          <div class="sr-only">
            <.link navigate={~p"/entry/#{entry}"}>Show</.link>
          </div>
          <.link navigate={~p"/entry/#{entry}/edit"}>Edit</.link>
        </:action>
        <:action :let={{id, entry}}>
          <.link
            phx-click={JS.push("delete", value: %{id: entry.id}) |> hide("##{id}")}
            data-confirm="Are you sure?"
          >
            Delete
          </.link>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Entry")
     |> stream(:entry_collection, list_entry())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    entry = Entries.get_entry!(id)
    {:ok, _} = Entries.delete_entry(entry)

    {:noreply, stream_delete(socket, :entry_collection, entry)}
  end

  defp list_entry() do
    Entries.list_entry()
  end
end
