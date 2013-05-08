class Parser

  def parse(text)
    arr = text.split()
    user = User.find_or_create_by(name: arr[0])

    command = arr[1]
    args = arr[2..-1]

    klass = command.classify.constantize

    # make sure to save the user
    #user.save! unless user.persisted?
    [user, klass, args]
  end
end
