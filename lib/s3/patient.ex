defmodule S3.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :full_name, :string
    field :tax_number, :string
    field :email, :string
    field :phone_number, :string
    field :health_insurance_type, Ecto.Enum, values: [:Particular, :Unimed, :Uniodonto]

    timestamps()
  end

  def changeset(patient \\ %__MODULE__{}, params) do
    patient
    |> cast(params, [:full_name, :tax_number, :email, :phone_number, :health_insurance_type])
    |> validate_required([:full_name, :tax_number, :email, :phone_number])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:tax_number)
  end
end
