class Room < ActiveRecord::Base
  belongs_to :dungeon

  def exit_info
    ext = Exit.where('room_one_id = ? OR room_two_id = ?', self.id)
    ext.reject! { |e| e.name == self.name }
    "Exits: #{ext.join(", ")}"
  end
end