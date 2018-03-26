class Blog < ApplicationRecord
  mount_uploader :photo, ImageUploader
  belongs_to :user

  validates :title, presence: true, length: { in: 1..140 }
  validates :content, presence: true, length: { in: 1..140 }
  validates :user_id, presence: true
  validates :photo, presence: true

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
