defmodule S3.Repo do
  use Ecto.Repo,
    otp_app: :s3,
    adapter: Ecto.Adapters.Postgres
end
