class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :first_name,      format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ }
    validates :last_name,       format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ }
    validates :first_name_read, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :last_name_read,  format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :birthday
  end

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }
end
