class Info < Command
  def perform(*args)
    room = @context[:user].room
    room.exit_info
  end
end