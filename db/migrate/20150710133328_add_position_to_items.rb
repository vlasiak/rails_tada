class AddPositionToItems < ActiveRecord::Migration
  def up
    add_column :items, :position, :integer

    ActiveRecord::Base.transaction do
      Item.reset_column_information

      lists = List.including_items
      lists.each do |list|
        list.items.where(done: false).order(:updated_at).each_with_index do |item, index|
          item.update_attribute(:position, index + 1)
        end
      end
    end
  end

  def down
    remove_column :items, :position
  end
end