class List < ActiveRecord::Base
  has_many :items, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :title, uniqueness: true

  scope :including_items, -> { includes(:items).order(:created_at) }
  scope :with_creator, -> { includes(:user) }
  scope :created_by, -> (email) { where(users: {email: email}) }
  scope :find_items, -> (text) { where('items.text ILIKE ?', "%#{text}%").order('items.position') }
  scope :with_status, -> (status) { where(items: {done: status }) }
end