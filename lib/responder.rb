class Responder

  def respond_to(user, response)

    message = "#{user.name} #{response}"

    puts message
  end
end
