defmodule S3.Doctor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "doctors" do
    field :full_name, :string
    field :professional_registration_number, :string

    timestamps()
  end

  def changeset(doctor \\ %__MODULE__{}, params) do
    doctor
    |> cast(params, [:full_name, :professional_registration_number])
    |> validate_required([:full_name, :professional_registration_number])
    |> unique_constraint(:professional_registration_number)
  end
end
