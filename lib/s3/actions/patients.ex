defmodule S3.Actions.Patients do
  alias S3.Patient
  alias S3.Repo

  def find_or_create(%{"tax_number" => tax_number} = patient_params) do
    case find(tax_number) do
      nil -> create(patient_params)
      patient -> {:ok, patient}
    end
  end

  def change(params), do: Patient.changeset(params)

  def find(tax_number) do
    Repo.get_by(Patient, tax_number: tax_number)
  end

  def create(params) do
    params
    |> Patient.changeset()
    |> Repo.insert()
  end
end
