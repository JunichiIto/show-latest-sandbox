class User < ActiveRecord::Base
  has_many :statuses
  validates :name, uniqueness: true, presence: true
end
