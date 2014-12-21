class Restaurant < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :client
  has_one :menu
  has_many :seats
end
