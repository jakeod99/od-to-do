# THIS FOLDER CONTAINS SEED INFO SPECIFIC TO THE O'DONNELL HOUSE IMPLEMENTATION
# IF YOU CHOOSE TO FORK THIS REPO FOR YOUR OWN TASK MANAGEMENT, REMOVE THIS OR REPLACE IT

Admin.create!([
  {
    email_address: ENV["JAKE_SEED_EMAIL"],
    password: ENV["JAKE_SEED_PWD"],
    password_confirmation: ENV["JAKE_SEED_PWD"],
    name: "Jake"
  },
  {
    email_address: ENV["AUDREY_SEED_EMAIL"],
    password: ENV["AUDREY_SEED_PWD"],
    password_confirmation: ENV["AUDREY_SEED_PWD"],
    name: "Audrey"
  }
])

User.create!(
  email_address: ENV["GRACE_SEED_EMAIL"],
  password: ENV["GRACE_SEED_PWD"],
  password_confirmation: ENV["GRACE_SEED_PWD"],
  name: "Grace"
)
