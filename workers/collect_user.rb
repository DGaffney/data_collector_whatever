class CollectAudience
  include Sidekiq::Worker
  include TwitterCreds

  def perform(user_set)
    users = client.users(user_set)
    users.each do |user|
      u = User.first_or_create(user_id: user.id)
      u.content = user.to_h
      u.save!
    end
  end
end

