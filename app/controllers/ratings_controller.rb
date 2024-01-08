class RatingsController < ApplicationController
  before_action :set_hotel, :set_item

  def create
    @rating = @item.ratings.new(rating_params)
    redirect_to hotel_item_url(@hotel, @item)
    if @rating.save
      flash[:notice] = 'Rating created successfully'
    else
      flash[:alert] = 'Rating should be selected'
    end
  end

  private

  def set_hotel
    @hotel = Hotel.find_by_id(params[:hotel_id])
  end

  def set_item
    @item = @hotel.items.find_by_id(params[:item_id])
  end

  def rating_params
    params.require(:rating).permit(:rate)
  end
end
