class Restaurant < ActiveRecord::Base
  validates :name, presence: true

  has_one :menu
  has_many :seats
end
