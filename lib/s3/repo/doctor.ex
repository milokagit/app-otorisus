defmodule S3.Repo.Doctor do
  import Ecto.Query, only: [from: 2]

  alias S3.Doctor
  alias S3.DoctorExpertise
  alias S3.Expertise

  def find_by_expertise(expertise_id) do
    from(
      doctor in Doctor,
      join: doctor_expertise in DoctorExpertise,
      on: doctor_expertise.doctor_id == doctor.id,
      join: expertise in Expertise,
      on: doctor_expertise.expertise_id == expertise.id,
      where: expertise.id == ^expertise_id,
      select: %{
        id: doctor.id,
        full_name: doctor.full_name,
        professional_registration_number: doctor.professional_registration_number
      }
    )
  end
end
