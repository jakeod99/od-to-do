# THIS FILE CONTAINS SEED INFO SPECIFIC TO THE O'DONNELL HOUSE IMPLEMENTATION
# IF YOU CHOOSE TO FORK THIS REPO FOR YOUR OWN TASK MANAGEMENT, REMOVE THIS OR REPLACE IT

jake    = User.find_by(email_address: ENV["JAKE_SEED_EMAIL"])
audrey  = User.find_by(email_address: ENV["AUDREY_SEED_EMAIL"])
parents = Group.find_by(name: "Parents")
men     = Group.find_by(name: "Men")

christianity = Category.find_by(name: "Christianity")
housework    = Category.find_by(name: "Housework")
yardwork     = Category.find_by(name: "Yardwork")
reading      = Category.find_by(name: "Reading")
food         = Category.find_by(name: "Food")


#########
# DAILY #
#########

DailyRecurringTaskTemplate.create!([
  {
    status: "active",
    title: "Jake's Devotional",
    description: "Jake's daily time in God's word. For details on what chapters are next, check your \"Devos\" Google sheet.",
    is_firm: true,
    complexity: :low,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ christianity, reading ]
  },
  {
    status: "active",
    title: "Audrey's Devotional",
    description: "Audrey's daily time in God's word.",
    is_firm: true,
    complexity: :low,
    urgency: :medium,
    author: jake,
    assign: audrey,
    categories: [ christianity, reading ]
  },
  {
    status: "active",
    title: "Family Worship",
    description: "Jake leads the family in our daily family worship (usually after dinner)",
    is_firm: true,
    complexity: :low,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ christianity ]
  },
  {
    status: "active",
    title: "Budget Updates",
    description: "Keep the family budget up to date",
    is_firm: true,
    complexity: :low,
    urgency: :low,
    author: jake,
    assign: jake
  },
  {
    status: "active",
    title: "Make Dinner",
    description: "Make and serve dinner",
    is_firm: true,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: audrey,
    categories: [ food ]
  }
])


##########
# WEEKLY #
##########

WeeklyRecurringTaskTemplate.create!([
  {
    status: "active",
    title: "Laundry",
    description: "Wash, dry, fold, and put away clothes",
    days: [ :sunday ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: audrey,
    categories: [ housework ]
  },
  {
    status: "active",
    title: "Gift Planning",
    description: "Check the planned gifts spreadsheet, and make sure the next 15 days of gifts are all on track for their presentation",
    days: [ :monday ],
    is_firm: false,
    complexity: :low,
    urgency: :low,
    author: jake,
    assign: jake
  },
  {
    status: "active",
    title: "Audrey's Workout",
    description: "Audrey's regular workout regiment",
    days: [ :monday, :thursday ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: audrey
  },
  {
    status: "active",
    title: "Jake's Cardio Workout",
    description: "Jake's regular cardio workout on the elliptical",
    days: [ :monday, :wednesday, :friday ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: jake
  },
  {
    status: "active",
    title: "Jake's Strength Workout",
    description: "Jake's regular strength workout",
    days: [ :thursday ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: jake
  },
  {
    status: "active",
    title: "Friend Text",
    description: "Decide on a friend to text, craft a message, and send it",
    days: [ :tuesday ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: audrey
  },
  {
    status: "active",
    title: "Evangelize Jeff",
    description: "Consider how to best move the ball forward with Jeff's spritual journey and execute accordingly",
    days: [ :wednesday ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: audrey,
    categories: [ christianity ]
  },
  {
    status: "active",
    title: "Jake's Reading",
    description: "Read the next chapter / segment of your current book (check reading spreadsheet if necessary)",
    days: [ :wednesday ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: jake,
    categories: [ reading ]
  },
  {
    status: "active",
    title: "Generic Theology Focus",
    description: "Digest some theological content (a sermon, a chapter of a book, a video, etc.)",
    days: [ :thursday ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: audrey,
    categories: [ christianity, reading ]
  },
  {
    status: "active",
    title: "Clean Bathrooms",
    description: "Clean any/all of the 3 bathrooms that need cleaned",
    days: [ :friday ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: audrey,
    categories: [ housework ]
  },
  {
    status: "active",
    title: "Clean Out Fridge",
    description: "Clean out any old expired stuff from the fridge and wipe down anything icky",
    days: [ :saturday ],
    is_firm: false,
    complexity: :low,
    urgency: :low,
    author: jake,
    assign: audrey,
    categories: [ housework, food ]
  },
  {
    status: "active",
    title: "Meal Plan",
    description: "Plan meals for the next week",
    days: [ :saturday ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: audrey,
    categories: [ food ]
  }
])


###########
# MONTHLY #
###########

MonthlyRecurringTaskTemplate.create!([
  {
    status: "active",
    title: "Budget New Month",
    description: "Set up this month in the budget spreadsheet by duplicating last month's tab and updating the appropriate columns / labels",
    days: [ 1 ],
    is_firm: false,
    complexity: :low,
    urgency: :medium,
    author: jake,
    assign: jake
  },
  {
    status: "active",
    title: "Hosting Plan",
    description: "Decide on who to host next and create all necessary tasks to make it happen",
    days: [ 1 ],
    is_firm: false,
    complexity: :low,
    urgency: :low,
    author: jake,
    assign: parents
  },
  {
    status: "active",
    title: "Jake's Haircut",
    description: "Cut Jake's hair (4 on sides, 7 on top)",
    days: [ 8 ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: audrey
  },
  {
    status: "active",
    title: "Septic Drain Treatment",
    description: "Pour a half-cap of Septic Blue solution down each drain in the house",
    days: [ 15 ],
    is_firm: false,
    complexity: :low,
    urgency: :high,
    author: jake,
    assign: jake,
    categories: [ housework ]

  },
  {
    status: "active",
    title: "Clean Ice Machine",
    description: "Without regular cleaning, the pellet ice maker starts growing moldy. Check for specific growth areas to focus on, and otherwise generally clean the rest",
    days: [ 22 ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: audrey,
    categories: [ housework ]
  }
])


##########
# YEARLY #
##########

YearlyRecurringTaskTemplate.create!([
  {
    status: "active",
    title: "Remove Leaves",
    description: "Blow or rake leaves and dump them deep into the wooded area by the shed. Usually best scheduled for Saturday",
    days: [ "1/4", "11/8", "11/15", "11/22", "11/29" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Boveda Cycle",
    description: "Carefully replace the 2 spent Boveda packs with fresh ones (2x Size-60 72% packs). Try to keep the humidor organized.",
    days: [ "1/10", "3/10", "5/10", "7/10", "9/10", "11/10" ],
    is_firm: false,
    complexity: :low,
    urgency: :low,
    author: jake,
    assign: jake,
    categories: [ housework ]
  },
  {
    status: "active",
    title: "Take Down Christmas Lights",
    description: "Remove all this year's Christmas lights, and put them away in an organized fashion",
    days: [ "1/11" ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Clean Septic Filter",
    description: "Remove septic tank caps, pull out filters, hose them clean, reinsert filters, and close caps. Neglecting to do this can cause damages north of $1k.",
    days: [ "1/20", "3/20", "5/20", "7/20", "9/20", "11/20" ],
    is_firm: false,
    complexity: :low,
    urgency: :high,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Lightbulb Jubilee",
    description: "Check every light fixture inside and outside the house, and replace any that are out",
    days: [ "1/25", "5/25", "9/25" ],
    is_firm: false,
    complexity: :medium,
    urgency: :low,
    author: jake,
    assign: parents,
    categories: [ housework ]
  },
  {
    status: "active",
    title: "Replace HVAC Air Filters",
    description: "Remove both old air filters and replace them with fresh ones. This keeps indoor air fresh, reduces the electric bill, and elongates the HVAC system lifespan",
    days: [ "2/5", "5/5", "9/5" ],
    is_firm: false,
    complexity: :low,
    urgency: :low,
    author: jake,
    assign: jake,
    categories: [ housework ]
  },
  {
    status: "active",
    title: "Spread Mulch",
    description: "Remove weeds and and any gross old mulch build-ups, then spread new mulch",
    days: [ "2/8" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Replace Fridge Water Filter",
    description: "Remove both old fridge water filter and replace it with a fresh ones. This keeps drinking water fresh and elongates the water filtration system lifespan",
    days: [ "2/12", "8/13" ],
    is_firm: false,
    complexity: :low,
    urgency: :low,
    author: jake,
    assign: jake,
    categories: [ housework ]
  },
  {
    status: "active",
    title: "Weed Whack",
    description: "Weed whack the deep-growth areas around the edges (drainage pits, fence, house, electrical boxes, trees, hedges, etc.). Be sure to keep crisp edges along the road, driveway, walkway, shed, and fire pit. Usually best scheduled for Saturday",
    days: [ "2/15", "4/5", "5/3", "6/7", "7/12", "8/23", "9/27", "10/25" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "John Deere Maintenance",
    description: "Change oil and do any other necessary tune-ups (check recommendations) to prepare the John Deere to start mowing this year",
    days: [ "3/1" ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "First Deep Mow",
    description: "Bag mow whole yard at John Deere deck level 1+2, with the goal of deep cutting old winter chaff. Usually best scheduled for Saturday",
    days: [ "3/8" ],
    is_firm: false,
    complexity: "very high",
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Spread Barricade Over Lawn",
    description: "Spread 80 pounds of 'The Andersons Barricade Professional-Grade Granular Pre-Emergent Weed Control'. This is poison, so take the proper precautions (gloves, breathing, signage, etc.). Usually best scheduled for Saturday, ideally after a bag mow",
    days: [ "3/8" ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Prune Branches",
    description: "Prune branches across the property, then cut any firewood-worthy chunks to size and store them to dry",
    days: [ "3/19", "8/16" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Powerwash",
    description: "Powerwash the driveway, walkway, porch, house, shed, and anything else that needs to be powerwashed",
    days: [ "3/22" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Mow",
    description: "Mow whole yard at John Deere deck level 3 (no bagging attachment). Usually best scheduled for Saturday",
    days: [ "3/29", "4/26", "5/3", "5/24", "5/31", "6/7", "6/21", "6/28", "7/12", "7/26", "8/9", "8/16", "8/23", "9/6", "9/20", "10/18" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Bag Mow",
    description: "Bag mow whole yard at John Deere deck level 3. Usually best scheduled for Saturday",
    days: [ "4/12", "5/10", "6/14", "7/19", "8/30", "10/4", "11/1" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Spread DuoCide Over Lawn",
    description: "Spread 40 pounds of 'The Andersons DuoCide Professional-Grade Lawn Insect Control'. This is poison, so take the proper precautions (gloves, breathing, signage, etc.). Usually best scheduled for Saturday, ideally after a bag mow",
    days: [ "4/12", "8/30" ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Spread Surge Over Wet Lawn",
    description: "Water the lawn, ensuring all broadleaf weeds are wet. Spread 40 pounds of 'The Andersons Professional Surge Weed and Feed 16-0-9 Post-Emergent Weed Control and Fertilizer' over the wet lawn. This is poison, so take the proper precautions (gloves, breathing, signage, etc.). Usually best scheduled for Sunday, the day after a spring DuoCide spread",
    days: [ "4/13" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Trim Hedges",
    description: "Trim Hedges across the property",
    days: [ "4/16", "10/15" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Maintain Outdoor Tools",
    description: "Clean, lubricate, and otherwise upkeep all outdoor-focused tools (Hedge Trimmer, Power Washer, Leaf Blower, Chainsaw, Pruning Shears, etc.)",
    days: [ "4/23" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Maintain Indoor Tools",
    description: "Clean, lubricate, and otherwise upkeep all indoor-focused tools (Miter Saw, Jigsaw, Circular Saw, Drill, Palm Router, Palm Sander, Workbench, Dremel, Batteries, etc.)",
    days: [ "4/30" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Plug Aerate Lawn",
    description: "Carefully get plug aerator out of shed, attach it, weigh it down, and run it across yard (skip drainage ditches)",
    days: [ "5/7" ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Spread Humichar Over Lawn",
    description: "Spread 80 pounds of 'The Andersons HumiChar Organic Soil Amendment with Humic Acid and Biochar Covers'",
    days: [ "5/8" ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Plant Centipede Grass Plugs",
    description: "Identify dead spots in the lawn to plant centipede grass plugs into (with slow release fertiziler under each plug). Usually best scheduled for Saturday, ideally after a bag mow",
    days: [ "5/10" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Water Grass Plugs",
    description: "Water all grass plugs to ensure root growth",
    days: [ "5/10", "5/11", "5/12", "5/13", "5/14", "5/15", "5/16", "5/17", "5/18", "5/19", "5/20", "5/21", "5/22" ],
    is_firm: true,
    complexity: :low,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Spread PGF Complete 16-4-8 Over Lawn",
    description: "Spread 40 pounds of 'The Andersons Professional PGF Complete 16-4-8 Fertilizer with Humic'. Usually best scheduled for Saturday, ideally after a bag mow",
    days: [ "6/14" ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Clear Gutters",
    description: "Clear the gutters, or hire someone to do it so you don't break your neck",
    days: [ "11/19" ],
    is_firm: false,
    complexity: :medium,
    urgency: :medium,
    author: jake,
    assign: men,
    categories: [ yardwork ]
  },
  {
    status: "active",
    title: "Hang Christmas Lights",
    description: "Hang all this year's Christmas lights",
    days: [ "11/26" ],
    is_firm: false,
    complexity: :high,
    urgency: :medium,
    author: jake,
    assign: jake,
    categories: [ yardwork ]
  }
])
