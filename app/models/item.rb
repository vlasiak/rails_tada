class Item < ActiveRecord::Base
  belongs_to :list
  acts_as_list scope: 'list_id = #{list_id} AND done = false'

  validates :text, :list_id, presence: true

  scope :incompleted, -> { where.not('done') }
  scope :completed, -> { where('done') }
  scope :for_today, -> {
    where('completed_at >= ? AND completed_at <= ?',
    Date.today.to_time.beginning_of_day,
    Date.today.to_time.end_of_day)
  }

  def mark
    transaction do
      update_attributes done: !done

      done? ? move_to_completed : move_to_incompleted
    end
  end

  private

  def move_to_completed
    unset_position
    set_completed_at
  end

  def move_to_incompleted
    set_highest_position
    unset_completed_at
  end

  def set_highest_position
    update_attributes position: list.items.incompleted.count
  end

  def unset_position
    remove_from_list
  end

  def set_completed_at
    update_attributes completed_at: DateTime.now
  end

  def unset_completed_at
    update_attributes completed_at: nil
  end

end