class Room < ActiveRecord::Base
  belongs_to :dungeon
  has_many :exits

  def exits
    
  end
end