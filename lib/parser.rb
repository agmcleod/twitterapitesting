class Parser
  class << self
    def parse(text)
      arr = text.split()

      command = arr[1]
      args = arr[2..-1]

      klass = command.classify.constantize
      [klass, args]
    end
  end
end