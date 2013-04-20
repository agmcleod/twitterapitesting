class MentionTrack
  def initialize
    puts 'stream should start'
    TweetStream::Client.new.track("@atweetdungeon") do |status|
      puts "logged: #{status.text}"
      Mention.create! text: status.text
    end
  end
end