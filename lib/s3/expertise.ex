defmodule S3.Expertise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expertises" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  def changeset(expertise \\ %__MODULE__{}, params) do
    expertise
    |> cast(params, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
