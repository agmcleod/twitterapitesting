class Go
  class << self
    def do(*args)
      puts "#{self.class} do"
    end
  end
end