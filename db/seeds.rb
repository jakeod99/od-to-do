# Sorts files from db/seeds alphabetically and loads them in order
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end
