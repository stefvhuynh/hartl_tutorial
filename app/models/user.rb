class User < ActiveRecord::Base
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  def formatted_email
    "#{self.name} <#{self.email}>"
  end
end
