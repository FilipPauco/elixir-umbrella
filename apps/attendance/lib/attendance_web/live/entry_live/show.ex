defmodule AttendanceWeb.EntryLive.Show do
  use AttendanceWeb, :live_view

  alias Attendance.Entries

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Entry {@entry.id}
        <:subtitle>This is a entry record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/entry"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/entry/#{@entry}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit entry
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Name">{@entry.name}</:item>
        <:item title="From">{@entry.from}</:item>
        <:item title="To">{@entry.to}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Entry")
     |> assign(:entry, Entries.get_entry!(id))}
  end
end
