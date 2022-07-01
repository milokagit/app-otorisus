defmodule S3.Repo.Migrations.CreateExpertises do
  use Ecto.Migration

  def change do
    create table("expertises") do
      add :name, :string, null: false
      add :description, :string

      timestamps()
    end

    create index("expertises", [:name], unique: true)
  end
end
