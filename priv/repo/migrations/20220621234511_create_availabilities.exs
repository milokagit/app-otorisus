defmodule S3.Repo.Migrations.CreateAvailabilities do
  use Ecto.Migration

  def change do
    create table("availabilities") do
      add :doctor_id, references("doctors")
      add :weekday, :string
      add :hour, :integer

      timestamps()
    end

    create(index("availabilities", :doctor_id))
  end
end
