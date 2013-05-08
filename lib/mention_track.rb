require 'command'
require 'exit'
require 'room'
require 'dungeon'

class MentionTrack
  def initialize
    accnt = "@atweetdungeon"

    puts 'stream should start'
    client = TweetStream::Client.new

    client.on_error do |message|
      puts message
    end
    @parser = Parser.new

    dungeon = Dungeon.new
    dungeon.rooms = [Room.new, Room.new, Room.new]
    exits = [
      Exit.new(room_one: dungeon.rooms[0], room_two: dungeon.rooms[1]),
      Exit.new(room_one: dungeon.rooms[1], room_two: dungeon.rooms[2])
    ]

    client.track("@atweetdungeon") do |status|
      puts "logged: #{status.text}"
      Mention.create!(text: status.text, username: status.user.name)

      puts Mention.all.to_a.inspect
      # parse
      user, klass, args = @parser.parse(status.text)
      # perform
      if klass.is_a?(Command)
        context = {user: user}
        commander = klass.new(context)
        commander.perform(args)
      else
        puts "Not a valid command"
      end
    end
  end
end
