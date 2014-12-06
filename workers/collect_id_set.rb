class CollectIdSet
  include Sidekiq::Worker
  include TwitterCreds

  def perform(id)
    set = client.follower_ids(id).to_h
    while set.next_cursor != 0
      id_set = IdSet.first_or_create(user_id: user_id, next_cursor: set.next_cursor, previous_cursor: set.previous_cursor, direction: "follower")
      id_set.ids = set.ids
      id_set.save!
      set = client.follower_ids(account, cursor: set.next_cursor).to_h
    end
  end
end
