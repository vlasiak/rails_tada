class AttachExistingListsToUser < ActiveRecord::Migration
  def up
    user = User.find_by_email 'vasyll@interlink-ua.com'
    lists = List.all

    lists.update_all user_id: user.id
  end

  def down
    lists = List.all
    lists.update_all user_id: nil
  end
end
