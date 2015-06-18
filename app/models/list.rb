class List < ActiveRecord::Base
  has_many :items

  validates :title, presence: true
  validates :title, uniqueness: true

  scope :including_items, -> { includes(:items).all }
end
