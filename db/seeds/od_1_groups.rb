# THIS FOLDER CONTAINS SEED INFO SPECIFIC TO THE O'DONNELL HOUSE IMPLEMENTATION
# IF YOU CHOOSE TO FORK THIS REPO FOR YOUR OWN TASK MANAGEMENT, REMOVE THIS OR REPLACE IT

Group.create!(
  name: "Parents",
  description: "For tasks that can only reasonably done by a parent, but that could be done by either parent",
  color: "#D7FFFF",
  icon: "person-hearts"
)
Group.create!(
  name: "Kids",
  description: "For tasks that should be done by a child, but that could be done by any child",
  color: "#D7D7FF",
  icon: "diagram-3"
)
Group.create!(
  name: "Women",
  description: "For tasks that should be done by a female, but that could be done by any female",
  color: "#FFD7EB",
  icon: "gender-female"
)
Group.create!(
  name: "Men",
  description: "For tasks that should be done by a male, but that could be done by any male",
  color: "#E1F0FF",
  icon: "gender-male"
)
