defmodule S3.Actions.Expertises do
  alias S3.Repo
  alias S3.Expertise

  def all, do: Repo.all(Expertise)
end
