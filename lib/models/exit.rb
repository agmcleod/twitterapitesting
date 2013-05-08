class Exit < ActiveRecord::Base
  belongs_to :room_one, class_name: "Room"
  belongs_to :room_two, class_name: "Room"
end