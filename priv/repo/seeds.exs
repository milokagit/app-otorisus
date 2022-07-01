# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     S3.Repo.insert!(%S3.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

d1 =
  S3.Repo.insert!(%S3.Doctor{
    full_name: "Thayssa Motta Costa",
    professional_registration_number: "CRO-PA 5671"
  })

d2 =
  S3.Repo.insert!(%S3.Doctor{
    full_name: "Viviane Medeiros",
    professional_registration_number: "CRO-PA 5036"
  })

e1 =
  S3.Repo.insert!(%S3.Expertise{
    name: "Odontopediatria"
  })

e2 =
  S3.Repo.insert!(%S3.Expertise{
    name: "Cirurgiã-Dentista"
  })

e3 =
  S3.Repo.insert!(%S3.Expertise{
    name: "Prótese Dentária"
  })

S3.Repo.insert!(%S3.DoctorExpertise{
  doctor_id: d1.id,
  expertise_id: e1.id
})

S3.Repo.insert!(%S3.DoctorExpertise{
  doctor_id: d2.id,
  expertise_id: e2.id
})

S3.Repo.insert!(%S3.DoctorExpertise{
  doctor_id: d2.id,
  expertise_id: e3.id
})

S3.Repo.insert!(%S3.Availability{
  doctor_id: d1.id,
  weekday: "Monday",
  hour: 8
})

S3.Repo.insert!(%S3.Availability{
  doctor_id: d1.id,
  weekday: "Monday",
  hour: 9
})

S3.Repo.insert!(%S3.Availability{
  doctor_id: d1.id,
  weekday: "Monday",
  hour: 10
})

S3.Repo.insert!(%S3.Availability{
  doctor_id: d1.id,
  weekday: "Monday",
  hour: 11
})

S3.Repo.insert!(%S3.Availability{
  doctor_id: d1.id,
  weekday: "Monday",
  hour: 12
})
