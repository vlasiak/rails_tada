class Item < ActiveRecord::Base
  belongs_to :list
  acts_as_list scope: :list

  validates :text, :list_id, presence: true

  def incompleted_count
    list.incompleted_items.size
  end
end
