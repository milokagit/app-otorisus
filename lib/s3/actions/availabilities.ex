defmodule S3.Actions.Availabilities do
  alias S3.Repo
  alias S3.Repo.Availability, as: AvailabilityRepo

  @default_interval 93

  @weekdays %{
    "Sunday" => 1,
    "Tuesday" => 2,
    "Wednesday" => 3,
    "Thursday" => 4,
    "Friday" => 5,
    "Saturday" => 6,
    "Monday" => 7
  }

  # TODO: Recuperar os horários disponíveis para esse dia e esse médico
  def find_hours_by_date(_date, _doctor_id) do
    Enum.to_list(8..18)
  end

  def find_by_doctor(doctor_id) when is_binary(doctor_id) do
    {id, _} = Integer.parse(doctor_id)

    find_by_doctor(id)
  end

  def find_by_doctor(doctor_id) do
    doctor_id
    |> dates_avaiable()
    |> remove_busy_days(doctor_id)
  end

  defp dates_avaiable(doctor_id, interval \\ @default_interval) do
    weekdays_keys =
      case AvailabilityRepo.find_availabilities_by_doctor(doctor_id) |> Repo.all() do
        [] ->
          Map.values(@weekdays)

        weekdays ->
          keys =
            weekdays
            |> Enum.map(& &1.weekday)
            |> Enum.uniq()

          @weekdays
          |> Map.take(keys)
          |> Map.values()
      end

    Date.range(Timex.today(), Timex.today() |> Timex.shift(days: interval))
    |> Enum.take(interval)
    |> Enum.filter(fn date ->
      Enum.member?(weekdays_keys, date |> Date.to_erl() |> :calendar.day_of_the_week())
    end)
    |> Enum.map(fn date ->
      {:ok, date_avaiable} = Timex.format(date, "%d/%m/%Y", :strftime)
      date_avaiable
    end)
  end

  # TODO: Recuperar as datas ocupadas na agenda do médico para remover das datas disponíveis
  defp remove_busy_days(dates, _doctor_id) do
    dates
  end
end
