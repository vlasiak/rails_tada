class List < ActiveRecord::Base
  has_many :items, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: true

  scope :including_items, -> { includes(:items).order(:created_at) }

  def completed_items
    sort_items items.select { |item| item.done? }
  end

  def incompleted_items
    sort_items items.reject { |item| item.done? }
  end

  def has_items?
    items.present?
  end

  def sort_items items
    items.sort_by {|item| item.position}
  end

end
