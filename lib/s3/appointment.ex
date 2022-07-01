defmodule S3.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    belongs_to(:doctor, S3.Doctor)
    belongs_to(:patient, S3.Patient)
    belongs_to(:expertise, S3.Expertise)
    field(:scheduled_to, :string)
    field(:hour, :integer)

    timestamps()
  end

  def changeset(data \\ %__MODULE__{}, params) do
    data
    |> cast(params, [:doctor_id, :patient_id, :expertise_id, :scheduled_to, :hour])
    |> validate_required([:doctor_id, :patient_id, :expertise_id, :scheduled_to, :hour])
  end
end
