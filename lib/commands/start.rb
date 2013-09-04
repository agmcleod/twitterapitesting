class Start < Command
  def perform(*args)
    room = @context[:user].room
    "Welcome, you are in room: #{room.name}"
  end
end
