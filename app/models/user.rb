class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\+[1-9]\d{1,14}\z/

  has_one :address_detail

  # allowed regex for phone number
  validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX }
  
  # allowed regex for email
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  # checks if otp passed is valid for user
  def valid_otp?(input_otp)
    otp == input_otp
  end
end
