class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_post
  before_action :find_comment, only: [:destroy,:edit,:update,:comment_owner]
  #before_action :comment_owner, only: [:destroy,:edit, :update]

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save

    respond_to do |format|
        if @comment.save
            format.html { redirect_to @post, notice: 'Comment was successfully created' }
            format.json { render :show, status: :created, location: @post }
            format.js
        else
            format.html { render :new }
            format.json { render json: @post.errors, status: :unprocessable_entity }
            format.js
        end
    end
  end
 def update
    if @comment.update(params[:comment].permit(:content))
        redirect_to post_path(@post)
    else
        render 'edit'
    end
 end

  def show

  end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end

def find_comment
    @comment = @post.comments.find(params[:id])
end
def comment_owner
    unless current_user.id == @comment.user_id
        flash[:notice] = "Nice trick ;P"
        redirect_to @post
    end
end

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :parent_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
