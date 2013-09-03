class MentionTrack
  def initialize
    accnt = "@atweetdungeon"

    puts 'stream should start'
    client = TweetStream::Client.new

    client.on_error do |message|
      puts message
    end
    @responder = Responder.new

    dungeon = Dungeon.new
    dungeon.rooms = [Room.new, Room.new, Room.new]
    exits = [
      Exit.new(room_one: dungeon.rooms[0], room_two: dungeon.rooms[1]),
      Exit.new(room_one: dungeon.rooms[1], room_two: dungeon.rooms[2])
    ]

    client.track("@atweetdungeon") do |status|
      puts "logged: #{status.text}"
      # parse
      user = User.find_or_create_by(name: status.user.screen_name)
      klass, args = Parser.parse(status.text)
      user.room = rooms[0]
      puts klass.inspect
      # perform
      if klass <= Command
        context = {user: user, dungeon: dungeon, exits: exits}
        commander = klass.new(context)
        response = commander.perform(args)

        #respond_to
        @responder.respond_to(user, response)

      else
        puts "Not a valid command"
      end

    end
  end
end
