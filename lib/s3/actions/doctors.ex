defmodule S3.Actions.Doctors do
  alias S3.Doctor
  alias S3.Repo.Doctor, as: DoctorRepo
  alias S3.Repo

  def find_by_expertise(expertise_id) do
    expertise_id
    |> DoctorRepo.find_by_expertise()
    |> Repo.all()
  end

  def find(id), do: Repo.get(Doctor, id)
end
