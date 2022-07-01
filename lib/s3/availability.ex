defmodule S3.Availability do
  use Ecto.Schema
  import Ecto.Changeset

  schema "availabilities" do
    belongs_to(:doctor, S3.Doctor)
    field(:weekday, :string)
    field(:hour, :integer)

    timestamps()
  end

  def changeset(data \\ %__MODULE__{}, params) do
    data
    |> cast(params, [:doctor_id, :weekday, :hour])
    |> validate_required([:doctor_id, :weekday, :hour])
  end
end
