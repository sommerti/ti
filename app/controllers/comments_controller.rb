class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
  	@comment = @trip.comments.new(comment_params)
  	@comment.user = current_user

  	if @comment.save
  		flash[:notice] = "Comment added."
  		redirect_to @trip
  	else
   		flash[:alert] = "Comment can't be empty."
  		redirect_to @trip
  	end
  end

  def edit

  end

  def update
  	if @comment.update(comment_params)
  		flash[:notice] = "Comment added."
  		redirect_to @trip
  	else
  		render "edit"
  	end
  end

  def destroy
  	@comment.destroy
  	flash[:notice] = "Comment deleted"
  	redirect_to @trip
  end

private
  
  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
  
  def set_trip    
    @trip = Trip.friendly.find(params[:trip_id])
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
end
