require 'command'

class MentionTrack
  def initialize
    accnt = "@atweetdungeon"

    puts 'stream should start'
    client = TweetStream::Client.new

    client.on_error do |message|
      puts message
    end

    client.track("@atweetdungeon") do |status|
      puts status.text
      message = status.text.gsub(accnt, '').strip
      user = User.find_or_create_by(name: status.user.screen_name)
      Command.parse(message, user)
    end
  end
end
