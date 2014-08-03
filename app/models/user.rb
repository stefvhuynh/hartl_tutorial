require 'bcrypt'

class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates(
    :name, :email, :password_digest, :password, 
    :password_confirmation, presence: true
  )
  
  validates(
    :email, uniqueness: { case_sensitive: false }, 
    format: { with: VALID_EMAIL_REGEX }
  )
  
  validates :name, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }
  validate :password_matches_confirmation
  
  attr_reader :password 
  attr_accessor :password_confirmation
  after_initialize { self.email = self.email.downcase }
  # Can get rid of all password and password_confirmation related methods if
  # this easy method is used...
  # has_secure_password

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end
  
  def authenticate(password)
    user = User.find_by_email(self.email)
    is_password?(password) ? user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  private
  
  def password_matches_confirmation
    unless self.password == self.password_confirmation
      errors[:password] << "confirmation does not match password"
    end
  end
  
end
