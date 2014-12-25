class Restaurant < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :client
  has_one :menu
  has_many :seats

  scope :filtered_per_page, ->(filtering_params, pagination_params) { where(filtering_params).page(pagination_params[:page]).per(pagination_params[:per_page]) }
end
