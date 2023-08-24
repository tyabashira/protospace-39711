class User < ApplicationRecord
  validates :email, presence: true
  validates :username, presence: true
  validates :profile, presence: true
  validates :occupation, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :prototypes
  has_many :comments
end
