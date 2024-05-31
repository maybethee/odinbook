class Profile < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :user_id
  validates :name, length: { minimum: 2, maximum: 20 }, allow_nil: true
  validates :bio, length: { maximum: 200 }

  validates :user_id, presence: true
end
