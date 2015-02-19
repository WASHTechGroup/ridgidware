class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable
  extend FriendlyId
  friendly_id :username, use: :slugged
  belongs_to :role
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  YEAR_REGEX = /\A[1-4][A-B]\Z/
  PHONE_REGEX = /\A[0-9]{10}|([0-9]{3})-[0-9]{3}-[0-9]{4}|\Z/
  validates :year,  length: { maximum: 2 }, 
                    format: { with: YEAR_REGEX }
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :phonenumber, length: { maximum: 10 },
                          format: { with: PHONE_REGEX }

  before_create :set_default_role

  private

  def set_default_role 
  	self.role ||= Role.find_by_name('Student') 
  end
end
