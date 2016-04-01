class MentionTrack
  def initialize
    @settings = YAML.load IO.read(File.expand_path(File.dirname(__FILE__) + '/../config/application.yml'))
    accnt = "@atweetdungeon"

    puts 'stream should start'
    client = TweetStream::Client.new

    client.on_error do |message|
      puts message
    end
    @responder = Responder.new

    listen_to_mentions(client)
  end

private

  def get_dungeon
    # TODO: Dungeon needs to be scoped per twitter user
    if Dungeon.count == 0
      dungeon = Dungeon.new
      ActiveRecord::Base.transaction do
        dungeon.rooms = [Room.new(name: "entrance"), Room.new(name: "hall"), Room.new(name: "dining hall")]
        dungeon.save!
        Exit.create! room_one: dungeon.rooms[0], room_two: dungeon.rooms[1]
        Exit.create! room_one: dungeon.rooms[1], room_two: dungeon.rooms[2]
      end
      dungeon
    else
      Dungeon.first
    end
  end

  def get_user(dungeon, user_name)
    user = User.find_or_create_by(name: user_name)
    if user.room.nil?
      user.room = dungeon.rooms[0]
      user.save!
    end
    user
  end

  def listen_to_mentions(client)
    dungeon = get_dungeon
    puts 'start listening'
    client.on_direct_message do |status|
      puts "logged: #{status.text}"
      # parse
      user = get_user(dungeon, status.user.screen_name)
      klass, args = Parser.parse(status.text)

      puts klass.inspect
      # perform
      if klass <= Command
        context = {user: user, dungeon: dungeon}
        commander = klass.new(context)
        response = commander.perform(args)

        #respond_to
        @responder.respond_to(user, response)

      else
        puts "Not a valid command"
      end
    end

    client.userstream
  end
end
