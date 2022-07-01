defmodule S3.Repo.Appointment do
  import Ecto.Query, only: [from: 2]

  alias S3.Appointment

  def find_busy_days_by_doctor(doctor_id) do
    from(appointment in Appointment,
      where: appointment.doctor_id == ^doctor_id,
      group_by: appointment.scheduled_to,
      select: %{
        scheduled_to: appointment.scheduled_to,
        weekday: fragment("TO_CHAR(TO_DATE(?, 'DD/MM/YYYY'), 'Day')", appointment.scheduled_to),
        hour: appointment.hour
      }
    )
  end

  def list() do
    today = Timex.now() |> Timex.Timezone.convert("America/Fortaleza") |> Timex.to_date()

    from(
      appointment in Appointment,
      where: fragment("TO_DATE(?, 'DD/MM/YYYY') >= ?", appointment.scheduled_to, ^today)
    )
  end
end
