class User
  include MongoMapper::Document
  key :user_id, Integer
  key :content, Hash
end