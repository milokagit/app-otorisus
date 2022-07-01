defmodule S3Web.Admin.AppointmentsLive do
  use S3Web, :live_view

  alias S3.Actions.Appointments, as: Appointments

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:secure, %{authorize: false})
     |> assign(:appointments, [])}
  end

  def handle_event("passcode", %{"passcode" => "!QAZxsw2"} = _params, socket) do
    appointments = Appointments.list()

    {:noreply,
     socket
     |> assign(:secure, %{authorize: true})
     |> assign(:appointments, appointments)}
  end
end
