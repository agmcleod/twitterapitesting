require 'command'

class MentionTrack
  def initialize
    accnt = "@atweetdungeon"

    puts 'stream should start'
    client = TweetStream::Client.new

    client.on_error do |message|
      puts message
    end
    @parser = Parser.new

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
