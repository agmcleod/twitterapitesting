require 'command'

class MentionTrack
  def initialize
    accnt = "@atweetdungeon"

    puts 'stream should start'
    TweetStream::Client.new.track(accnt) do |status|
      puts "logged: #{status.text}"
      message = status.text.gsub(accnt, '').strip
      user = User.find_or_create_by(name: status.user.screen_name)
      Command.parse(message, user)
    end
  end
end