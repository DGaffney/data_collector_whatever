class IdSet
  include MongoMapper::Document
  key :user_id, Integer
  key :ids, Array
  key :direction, String
  key :next_cursor, Integer
  key :previous_cursor, Integer
end