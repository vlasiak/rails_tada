class Item < ActiveRecord::Base
  belongs_to :list
  acts_as_list scope: :list

  validates :text, :list_id, presence: true
end
