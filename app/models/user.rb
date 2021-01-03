class User < ApplicationRecord
  include BCrypt
  has_many :records, dependent: :destroy
  has_many :rooms, through: :records

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :pennkey, presence: true
  validates :password_hash, presence: true
  validates :pennkey, uniqueness: true
  

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.students 
    User.where(is_faculty: false)
  end

  def self.faculties 
    User.where(is_faculty: true)
  end
end
