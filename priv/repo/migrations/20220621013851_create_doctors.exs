defmodule S3.Repo.Migrations.CreateDoctors do
  use Ecto.Migration

  def change do
    create table("doctors") do
      add :full_name, :string
      add :professional_registration_number, :string

      timestamps()
    end

    create index("doctors", [:professional_registration_number], unique: true)
  end
end
