class Go < Command

  def perform(*args)
    @user.update_attribute(room_id: 1)
    
  end
end
