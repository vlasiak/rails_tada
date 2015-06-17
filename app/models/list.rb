class List < ActiveRecord::Base
  has_many :items

  validates :title, presence: true
  validates :title, uniqueness: true
end
