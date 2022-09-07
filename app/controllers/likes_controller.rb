class LikesController < ApplicationController

  def create
   @like = current_user.likes.new
   if !@like.save
    flash[:notice] = @like.errors.full_messages.to_sentence
   end
   redirect_to posts_path
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    post = @like.post
    @like.destroy
    redirect_to post
  end

  private

   def like_params
    params.require(:Like).permit(:post_id)
   end
end
