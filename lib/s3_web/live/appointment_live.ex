defmodule S3Web.AppointmentLive do
  use S3Web, :live_view

  alias S3.Actions.Availabilities, as: Availabilities
  alias S3.Actions.Appointments, as: Appointments
  alias S3.Actions.Doctors, as: Doctors
  alias S3.Actions.Expertises, as: Expertises
  alias S3.Actions.Patients, as: Patients

  def mount(%{"tax_number" => tax_number} = _params, _session, socket) do
    patient = Patients.find(tax_number)
    expertises = Expertises.all()

    {:ok,
     socket
     |> assign(:expertises, expertises)
     |> assign(:doctors, [])
     |> assign(:availabilities, [])
     |> assign(:hours, [])
     |> assign(:changeset, Appointments.change(%{patient_id: patient.id}))}
  end

  def handle_event(
        "selection",
        %{
          "_target" => ["appointment", "expertise_id"],
          "appointment" => %{"expertise_id" => expertise_id} = appointment_params
        } = _params,
        socket
      ) do
    doctors = Doctors.find_by_expertise(expertise_id)

    {:noreply,
     socket
     |> assign(:doctors, doctors)
     |> assign(:changeset, Appointments.change(appointment_params))}
  end

  def handle_event(
        "selection",
        %{
          "_target" => ["appointment", "doctor_id"],
          "appointment" => %{"doctor_id" => doctor_id} = appointment_params
        } = _params,
        socket
      ) do
    availabities = Availabilities.find_by_doctor(doctor_id)

    {:noreply,
     socket
     |> assign(:availabilities, availabities)
     |> assign(:changeset, Appointments.change(appointment_params))}
  end

  def handle_event(
        "selection",
        %{
          "_target" => ["appointment", "scheduled_to"],
          "appointment" =>
            %{"scheduled_to" => scheduled_to, "doctor_id" => doctor_id} = appointment_params
        } = _params,
        socket
      ) do
    hours = Availabilities.find_hours_by_date(scheduled_to, doctor_id)

    {:noreply,
     socket
     |> assign(:hours, hours)
     |> assign(:changeset, Appointments.change(appointment_params))}
  end

  def handle_event(
        "selection",
        %{"appointment" => appointment_params} = _params,
        socket
      ) do
    {:noreply,
     socket
     |> assign(:changeset, Appointments.change(appointment_params))}
  end

  def handle_event(
        "save",
        %{"appointment" => appointment_params} = _params,
        socket
      ) do
    case Appointments.create(appointment_params) do
      {:ok, _appointment} ->
        {:noreply,
         socket
         |> put_flash(:info, gettext("appointment scheduled"))
         |> redirect(to: Routes.live_path(socket, S3Web.StartLive))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
