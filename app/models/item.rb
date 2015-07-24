class Item < ActiveRecord::Base
  belongs_to :list
  acts_as_list scope: 'list_id = #{list_id} AND done = false'

  validates :text, :list_id, presence: true

  scope :incompleted, -> { where.not('done') }
  scope :completed, -> { where('done') }

  def mark
    transaction do
      update_attributes done: !done

      done? ? unset_position : set_highest_position
    end
  end

  private

  def unset_position
    remove_from_list
  end

  def set_highest_position
    update_attributes position: list.items.incompleted.count
  end
end