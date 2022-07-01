defmodule S3.Repo.Migrations.CreateDoctorsExpertises do
  use Ecto.Migration

  def change do
    create table("doctors_expertises") do
      add :doctor_id, references("doctors")
      add :expertise_id, references("expertises")

      timestamps()
    end

    create index("doctors_expertises", [:doctor_id, :expertise_id], unique: true)
  end
end
