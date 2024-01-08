class ItemsController < ApplicationController
  before_action :set_hotel, only: %i[index show new create update edit destroy]
  before_action :set_item, only: %i[ show edit update destroy item_user_read_status]
  before_action :set_comments, only: %i[ show ]
  skip_before_action :verify_authenticity_token, :only => [:item_user_read_status]

  load_and_authorize_resource

  # GET /items or /items.json
  def index
    if params[:hotel_id].present?
      @items = @hotel.items.all
    else
      @items = Item.all
    end
    @pagy, @items = pagy(@items.all)
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.tags.build
  end

  # GET /items/1/edit
  def edit
    @item.tags.build
  end

  # POST /items or /items.json
  def create
    @item = @hotel.items.new(item_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @item.save
        format.html { redirect_to hotel_item_url(@hotel, @item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to hotel_item_url(@hotel, @item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to hotel_items_url(@hotel), notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def item_user_read_status
    @item.users << current_user
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    id = params[:id] || params[:items_id]
    @item = Item.find(id)
  end

  def set_hotel
    @hotel = Hotel.find_by(id: params['hotel_id'])
  end

  def set_comments
    @comments = @item.comments.all
    @comment = Comment.new
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:name, :description, :image, tag_ids: [], tags_attributes: [:id, :hashtag, :_destroy])
  end
end
