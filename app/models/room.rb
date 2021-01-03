class Room < ApplicationRecord
  has_many :records, dependent: :destroy
  has_many :users, through: :records
  has_many :comments
  validates :number, uniqueness: { scope: :location }
  validates :location, presence: true
  validates :number, presence: true
  validates :room_type, presence: true
  validates :description, presence: true
    
  def full_room
    "#{location}-#{number}"
  end
  
  def faculty
    users.find_by(is_faculty: true)
  end
  
  def faculty=(user)
    isTrue = user.is_faculty
    if isTrue then users << user end
  end
  
  def students
    self.users.where(is_faculty: false)
  end

end
