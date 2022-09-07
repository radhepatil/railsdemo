class PostsController < ApplicationController
  #mount_uploader :image, ImageUploader
  #before_action :current_user.posts
  # validate :picture_size


  def index
   @posts = Post.all
   @posts = Post.order('created_at DESC')
   render :json => @posts, each_serializer: PostsSerializer
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
   @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
     @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
        if @post.update(params[:post].permit(:title, :body, :image))
            redirect_to posts_path
        else
            render 'edit'
        end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    #redirect_to posts_path
     respond_to do |format|
      format.html { redirect_to ponies_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
   end
  end

  def like
    Like.create(user: current_user, like: params[:like])
    flash[:success] = "Like Counted!"
    redirect_to :back
  end



  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # def picture_size
  #   errors.add(:image, 'should be less than 1MB') if image.size > 1.megabytes
  # end

end
