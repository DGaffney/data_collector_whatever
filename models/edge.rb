class Edge
  include MongoMapper::Document
  key :source, Integer
  key :target, Integer
end
# Edge.ensure_index(:source)
# Edge.ensure_index(:target)
# (gg|ids).each do |id|
#   (IdSet.friends_for(id)&gg).each do |alter_id|
#     Edge.first_or_create(source: id, target: alter_id)
#     print "."
#   end
#   print ","
# end
# require "time"
# f = CSV.open("nodes.csv", "w")
# f << ["id", "label", "screen_name", "location", "name", "followers_count", "friends_count", "listed_count", "favourites_count", "created_at", "statuses_count"]
# User.where(user_id: (gg|ids)).fields(:content).each do |u|
#   u = u.content
#   f << [u.id, u.screen_name, u.screen_name, u.location, u.name, u.followers_count, u.friends_count, u.listed_count, u.favourites_count, Time.parse(u.created_at).to_i, u.statuses_count]
# end
# f.close