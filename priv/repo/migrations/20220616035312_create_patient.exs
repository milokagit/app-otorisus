defmodule S3.Repo.Migrations.CreatePatient do
  use Ecto.Migration

  def change do
    create table("patients") do
      add :full_name, :string
      add :tax_number, :string
      add :email, :string
      add :phone_number, :string
      add :health_insurance_type, :string

      timestamps()
    end

    create index("patients", [:tax_number], unique: true)
  end
end
