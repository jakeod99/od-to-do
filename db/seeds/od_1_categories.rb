# THIS FILE CONTAINS SEED INFO SPECIFIC TO THE O'DONNELL HOUSE IMPLEMENTATION
# IF YOU CHOOSE TO FORK THIS REPO FOR YOUR OWN TASK MANAGEMENT, REMOVE THIS OR REPLACE IT

Category.create!([
  {
    name: "Christianity",
    description: "Tasks directly pertaining to our walk with the Lord (though, biblically speaking, we do all the things we do as unto the Lord)",
    color: "#332920",
    icon: "heart"
  },
  {
    name: "Housework",
    description: "Tasks pertaining to living inside of our house (indoor maintenance, decorations, room-specific work, etc.)",
    color: "#003366",
    icon: "house"
  },
  {
    name: "Yardwork",
    description: "Tasks pertaining to our property outside the house (lawncare, hedge trimming, pruning, raking, powerwashing, etc.)",
    color: "#006600",
    icon: "tree"
  },
  {
    name: "Reading",
    description: "Tasks pertaining to reading (theology, novels, professional development, bible, etc.)",
    color: "#663300",
    icon: "book"
  },
  {
    name: "Food",
    description: "Tasks pertaining to food (grocery shopping, meal prep, meal donations, etc.)",
    color: "#660000",
    icon: "cookie"
  }
])
