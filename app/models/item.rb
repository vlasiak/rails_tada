class Item < ActiveRecord::Base
  belongs_to :list

  validates :text, :list_id, presence: true

  def associated_list_items
    list.items
  end

  scope :incompleted, -> { where(done: false) }
end
