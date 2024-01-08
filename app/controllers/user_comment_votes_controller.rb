class UserCommentVotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hotel
  before_action :set_item
  before_action :set_comment

  def create
    @user_comment_voting = @comment.user_comment_votes.new(user_id: current_user.id)
    @user_comment_voting.upvote = (params[:vote_type] == 'Up Vote' ? true : false)
    respond_to do |format|
      format.html {
        redirect_to(
          [@hotel,@item],
          notice: @user_comment_voting.save ? 'Rating saved successfully.' : @user_comment_voting.errors.full_messages[0]
        )
      }
    end
  end

  private
  def set_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

end