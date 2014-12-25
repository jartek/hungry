class RestaurantController < BaseController

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :client_id)
  end

end
