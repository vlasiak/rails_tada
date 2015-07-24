class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :validatable

  has_many :lists
end
