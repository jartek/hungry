class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  scope :filtered_per_page, ->(filtering_params, pagination_params) { where(filtering_params).page(pagination_params[:page]).per(pagination_params[:per_page]) }
end
