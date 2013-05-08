class Start < Command
  def perform(user_hash)
    User.create!(name: user.name, room_id: 0)

  end
end
