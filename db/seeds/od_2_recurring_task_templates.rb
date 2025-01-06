# THIS FOLDER CONTAINS SEED INFO SPECIFIC TO THE O'DONNELL HOUSE IMPLEMENTATION
# IF YOU CHOOSE TO FORK THIS REPO FOR YOUR OWN TASK MANAGEMENT, REMOVE THIS OR REPLACE IT



#########
# DAILY #
#########

author = User.find_by(email_address: ENV["JAKE_SEED_EMAIL"])

DailyRecurringTaskTemplate.create!(
  status: "",
  title: "",
  description: "",
  is_firm: false,
  complexity: "",
  urgency: "low",
  author: author
)
