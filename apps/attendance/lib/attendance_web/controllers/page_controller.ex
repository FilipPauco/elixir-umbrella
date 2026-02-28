defmodule AttendanceWeb.PageController do
  use AttendanceWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
