class Profile < ApplicationRecord
  belongs_to :user

  validates :nickname, presence: true, uniqueness: { scope: :user_id }
  validates :age, presence: true, numericality: { only_integer: true }
  validates :active, presence: true, numericality: { only_integer: true }
  validates :height, presence: true, numericality: true
end
