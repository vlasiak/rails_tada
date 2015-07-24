class AttachExistingListsToUser < ActiveRecord::Migration
  def up
    user = User.find_by_email 'vasyll@interlink-ua.com'
    List.update_all user_id: user.id
  end

  def down
    List.update_all user_id: nil
  end
end
