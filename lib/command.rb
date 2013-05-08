<<<<<<< HEAD
class Command

  def initialize(context)
    @context = context
=======
require 'active_support/inflector'

class Command
  class << self
    def parse(msg, *args)
      verb, *parts = msg.split(" ")
      verb.capitalize.constantize.do(*args)
    end
>>>>>>> basic model structure built for a dungeon
  end
end
