class CollectAudience
  include Sidekiq::Worker
  include TwitterCreds
  def self.queue_up
    ["everyoneisgay", "kristinnoeline", "pbsds", "thirteenny"].each do |account|
      CollectAudience.perform_async(account)
    end
  end

  def perform(account)
    user_id = client.user(account).id
    set = client.follower_ids(account).to_h
    while set.next_cursor != 0
      set.ids.each_slice(100) do |user_set|
        CollectUser.perform_async(user_set)
        user_set.each do |id|
          CollectIdSet.perform_async(id)
        end
        id_set = IdSet.first_or_create(user_id: user_id, next_cursor: set.next_cursor, previous_cursor: set.previous_cursor, direction: "follower")
        id_set.ids = set.ids
        id_set.save!
      end
      set = client.follower_ids(account, cursor: set.next_cursor).to_h
    end
  end
end

