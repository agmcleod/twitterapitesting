require 'active_support'

class Command
  include ActiveSupport::Inflector

  class << self
    def parse(msg, *args)
      verb, *parts = msg.split(" ")
      constantize(verb).do(*args)
    end
  end
end