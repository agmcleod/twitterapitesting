class MentionTrack
  def initialize
    puts 'stream should start'

    client = TweetStream::Client.new

    client.on_error do |message|
      puts message
    end

    client.track("@atweetdungeon") do |status|
      puts "logged: #{status.text}"
      Mention.create!(text: status.text, username: status.user.name)
      puts Mention.all.to_a.inspect
      puts status.text
    end
  end
end
