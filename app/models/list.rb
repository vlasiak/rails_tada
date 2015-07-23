class List < ActiveRecord::Base
  has_many :items, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: true

  scope :including_items, -> { includes(:items).order(:created_at) }
  scope :with_creator, -> { includes(:user) }
end