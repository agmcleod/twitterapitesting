class Parser
  class << self
    def parse(text)
      arr = text.split()

      command = arr[1]
      args = arr[2..-1]

      klass = command.classify.constantize

      # make sure to save the user
      #user.save! unless user.persisted?
      [klass, args]
    end
  end
end