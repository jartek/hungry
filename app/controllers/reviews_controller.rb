class ReviewsController < BaseController

  private

  def review_params
    params.require(:review).permit(:review, :client_id, :restaurant_id)
  end

end
