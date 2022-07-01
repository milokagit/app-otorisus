defmodule S3.Actions.Appointments do
  alias S3.Appointment

  alias S3.Repo
  alias S3.Repo.Appointment, as: AppointmentRepo

  def change(params), do: Appointment.changeset(params)

  def create(params) do
    params
    |> Appointment.changeset()
    |> Repo.insert()
  end

  def list() do
    AppointmentRepo.list()
    |> Repo.all()
    |> Repo.preload([:doctor, :patient, :expertise])
  end
end
