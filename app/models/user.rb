class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :trips, dependent: :destroy
  has_many :vehicles, dependent: :destroy
  has_many :places, dependent: :destroy

  validates :password, :address, presence: true
  validates :email, :pseudo, presence: true , uniqueness: true

end
