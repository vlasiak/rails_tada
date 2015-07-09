class List < ActiveRecord::Base
  has_many :items, -> { order(:updated_at) }, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: true

  scope :including_items, -> { includes(:items).order(:created_at) }

  def completed_items
    items.select { |item| item.done? }
  end

  def incompleted_items
    items.reject { |item| item.done? }
  end

  def has_items?
    items.present?
  end

end
