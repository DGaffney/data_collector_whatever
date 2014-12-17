class IdSet
  include MongoMapper::Document
  key :user_id, Integer
  key :ids, Array
  key :direction, String
  key :next_cursor, Integer
  key :previous_cursor, Integer
  
  def self.followers_for(ids)
    self.where(direction: "follower", user_id: ids).collect(&:ids).flatten.uniq
  end

  def self.friends_for(ids)
    self.where(direction: "friend", user_id: ids).collect(&:ids).flatten.uniq
  end
end