class Parser

  def parse(text)
    arr = text.split()
    user = User.where(name: arr[0]).first

    command = arr[1]
    args = arr[2..-1]

    klass = command.classify.constantize

    [user, klass, args]
  end
end
