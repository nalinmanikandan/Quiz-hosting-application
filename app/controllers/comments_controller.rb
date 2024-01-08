class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_hotel, only: %i[ show create edit update destroy ]
  before_action :set_item, only: %i[ show create edit update destroy ]

  # POST /comments or /comments.json
  def create
    @comment = @item.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to hotel_item_url(@hotel, @item), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        @comments = @item.comments.reload
        format.html { render 'items/show', hotel: @hotel, item: @item, comment: @comment, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to hotel_item_url(@hotel, @item), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to hotel_item_url(@hotel, @item), notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:message, :item_id)
    end
end
