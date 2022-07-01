defmodule S3.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table("appointments") do
      add(:doctor_id, references("doctors"))
      add(:patient_id, references("patients"))
      add(:expertise_id, references("expertises"))
      add(:scheduled_to, :string)
      add(:hour, :integer)

      timestamps()
    end

    create index("appointments", :doctor_id)
    create index("appointments", :patient_id)
    create index("appointments", :expertise_id)
    create index("appointments", [:scheduled_to, :hour], unique: true)
  end
end
