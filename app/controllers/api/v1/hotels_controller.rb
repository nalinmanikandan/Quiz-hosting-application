class Api::V1::HotelsController < ApplicationController

  before_action :set_hotel, only: %i[ show edit update destroy ]

  def index
    @hotels = Hotel.all
    render json: @hotels
  end

  def show
    render json: @hotel
  end

  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user_id = current_user.id
    if @hotel.save
      render json: @hotel
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  def update
    if @hotel.update(hotel_params)
      render json: @hotel
    else
      render json: @hotel.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @hotel.destroy
    render json: {message: 'Hotel Successfully Deleted'},status: :ok
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name)
  end

end
