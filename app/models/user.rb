class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable
  
  extend FriendlyId
  friendly_id :username, use: :slugged
  
  belongs_to :role
  belongs_to :cart, autosave: true
  has_many :transactions

  before_create :set_default_role
  before_save :set_default_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  YEAR_REGEX = /\A[1-4][A-B]\Z/
  PHONE_REGEX = /\A[0-9]{10}|([0-9]{3})-[0-9]{3}-[0-9]{4}|\Z/

  validates :username, presence: true 
  validates :term,  allow_nil: true,
                    length: { maximum: 2 }, 
                    format: { with: YEAR_REGEX }
  validates :email, allow_nil: true, format:     { with: VALID_EMAIL_REGEX }
  validates :phonenumber, allow_nil: true,
                          length: { maximum: 10 },
                          format: { with: PHONE_REGEX }

  def student?
    self.role == Role.find_by_name('Student')
  end

  def admin?
    self.role == Role.find_by_name('Admin')
  end

  def ordering_officer?
    self.role == Role.find_by_name('Ordering Officer')
  end

  def staff?
    self.role == Role.find_by_name('Staff')
  end

  def vpfin?
    self.role == Role.find_by_name('VPFin')
  end

  def manager?
    self.role == Role.find_by_name('Manager')
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  private

    def set_default_role 
    	self.role ||= Role.find_by_name('Student') 
    end

    def set_default_email
      self.email ||= "#{self.username}@uwaterloo.ca"
    end
end
