class CollectIdSet
  include Sidekiq::Worker
  include TwitterCreds

  def perform(id)
    if IdSet.first(user_id: id, direction: "friend").nil?
      set = client.friend_ids(id).to_h
      id_set = IdSet.first_or_create(user_id: id, next_cursor: set.next_cursor, previous_cursor: set.previous_cursor, direction: "friend")
      id_set.ids = set.ids
      id_set.save!
      while set.next_cursor != 0
        set = client.follower_ids(account, cursor: set.next_cursor).to_h
        id_set = IdSet.first_or_create(user_id: id, next_cursor: set.next_cursor, previous_cursor: set.previous_cursor, direction: "friend")
        id_set.ids = set.ids
        id_set.save!
      end
    end
  end
end
