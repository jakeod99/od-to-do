# THIS FOLDER CONTAINS SEED INFO SPECIFIC TO THE O'DONNELL HOUSE IMPLEMENTATION
# IF YOU CHOOSE TO FORK THIS REPO FOR YOUR OWN TASK MANAGEMENT, REMOVE THIS OR REPLACE IT


jake   = User.find_by(email_address: ENV["JAKE_SEED_EMAIL"])
audrey = User.find_by(email_address: ENV["AUDREY_SEED_EMAIL"])
grace  = User.find_by(email_address: ENV["GRACE_SEED_EMAIL"])

Group.create!([
  {
    name: "Parents",
    description: "The O'Donnell Parents",
    color: "#D7FFFF",
    icon: "person-hearts",
    users: [ jake, audrey ]
  },
  {
    name: "Kids",
    description: "The O'Donnell Children",
    color: "#D7D7FF",
    icon: "diagram-3",
    users: [ grace ]
  },
  {
    name: "Women",
    description: "The O'Donnell Ladies",
    color: "#FFD7EB",
    icon: "gender-female",
    users: [ audrey, grace ]
  },
  {
    name: "Men",
    description: "The O'Donnell Men",
    color: "#E1F0FF",
    icon: "gender-male",
    users: [ jake ]
  }
])
