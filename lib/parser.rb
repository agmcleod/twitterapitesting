class Parser

  def parse(text)
    arr = text.split()
    user = User.where(name: arr[0]).first_or_create

    command = arr[1]
    args = arr[2..-1]

    klass = command.classify.constantize

    # make sure to save the user
    user.save! unless user.persisted?
    [user, klass, args]
  end
end
