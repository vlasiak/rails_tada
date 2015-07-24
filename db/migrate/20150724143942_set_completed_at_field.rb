class SetCompletedAtField < ActiveRecord::Migration
  def up
    Item.completed.each do |item|
      item.update_attributes(completed_at: item.updated_at)
    end
  end

  def down
    Item.completed.update_all completed_at: nil
  end
end