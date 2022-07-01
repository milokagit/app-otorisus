defmodule S3Web.StartLive do
  use S3Web, :live_view

  alias S3.Actions.Patients, as: Patients

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:changeset, Patients.change(%{}))}
  end

  def handle_event(
        "validate",
        %{"patient" => %{"tax_number" => tax_number} = patient_params},
        socket
      ) do
    case Patients.find(tax_number) do
      nil ->
        patient_changeset =
          Patients.change(patient_params)
          |> Map.put(:action, :validate)

        {:noreply,
         socket
         |> assign(:changeset, patient_changeset)}

      patient ->
        {:noreply,
         socket
         |> assign(:changeset, Ecto.Changeset.change(patient, %{}))}
    end
  end

  def handle_event("next", %{"patient" => patient_params}, socket) do
    case Patients.find_or_create(patient_params) do
      {:ok, patient} ->
        {:noreply,
         socket
         |> put_flash(:info, gettext("patient confirmed"))
         |> redirect(to: Routes.live_path(socket, S3Web.AppointmentLive, patient.tax_number))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
