class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address_detail

  # checks if otp passed is valid for user
  def valid_otp?(input_otp)
    otp == input_otp
  end
end
