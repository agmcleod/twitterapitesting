class Command

  def initialize(context)
    @context = context
  end

  def user
    @context[:user]
  end
end
