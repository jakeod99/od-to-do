# THIS FILE CONTAINS SEED INFO SPECIFIC TO THE O'DONNELL HOUSE IMPLEMENTATION
# IF YOU CHOOSE TO FORK THIS REPO FOR YOUR OWN TASK MANAGEMENT, REMOVE THIS OR REPLACE IT

jake   = User.find_by(email_address: ENV["JAKE_SEED_EMAIL"])
audrey = User.find_by(email_address: ENV["AUDREY_SEED_EMAIL"])
grace  = User.find_by(email_address: ENV["GRACE_SEED_EMAIL"])

Group.create!([
  {
    name: "Parents",
    description: "The O'Donnell Parents",
    color: "#006666",
    icon: "person-hearts",
    users: [ jake, audrey ]
  },
  {
    name: "Kids",
    description: "The O'Donnell Children",
    color: "#000066",
    icon: "diagram-3",
    users: [ grace ]
  },
  {
    name: "Women",
    description: "The O'Donnell Ladies",
    color: "#660033",
    icon: "gender-female",
    users: [ audrey, grace ]
  },
  {
    name: "Men",
    description: "The O'Donnell Men",
    color: "#003366",
    icon: "gender-male",
    users: [ jake ]
  }
])
