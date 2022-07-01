defmodule S3.DoctorExpertise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "doctors_expertises" do
    belongs_to :doctor, S3.Doctor
    belongs_to :expertise, S3.Expertise

    timestamps()
  end

  def changeset(data \\ %__MODULE__{}, params) do
    data
    |> cast(params, [:doctor_id, :expertise_id])
    |> validate_required([:doctor_id, :expertise_id])
    |> unique_constraint([:doctor_id, :expertise_id])
  end
end
