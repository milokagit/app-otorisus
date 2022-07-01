defmodule S3.Repo.Availability do
  import Ecto.Query, only: [from: 2]

  alias S3.Availability

  def find_availabilities_by_doctor(doctor_id) do
    from(
      availability in Availability,
      where: availability.doctor_id == ^doctor_id
    )
  end
end
