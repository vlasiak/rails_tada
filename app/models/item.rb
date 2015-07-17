class Item < ActiveRecord::Base
  belongs_to :list
  acts_as_list scope: 'list_id = #{list_id} AND done = false'

  validates :text, :list_id, presence: true

  def mark
    Item.transaction do
      update_attributes done: !done

      done? ? remove_from_list : add_to_list
    end
  end

  def add_to_list
    update_attributes position: list.items.where(done: false).count
  end
end
