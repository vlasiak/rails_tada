class List < ActiveRecord::Base
  has_many :items, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: true

  scope :including_items, -> { includes(:items).order(:created_at) }
  scope :with_creator, -> { includes(:user) }

  def completed_items
    completed_items = items.select { |item| item.done? }
    completed_items.sort_by { |item| item.updated_at }
  end

  def incompleted_items
    incompleted_items = items.reject { |item| item.done? }
    incompleted_items.sort_by { |item| item.position }
  end

  def has_items?
    items.present?
  end
end