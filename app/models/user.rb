class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :cas_authenticatable
  extend FriendlyId
  friendly_id :username, use: :slugged
end
