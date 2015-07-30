class SetCompletedAtField < ActiveRecord::Migration
  def up
    Item.completed.update_all 'completed_at = updated_at'
  end

  def down
    Item.completed.update_all 'completed_at = null'
  end
end