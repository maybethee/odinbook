class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      puts @post.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(profile_params)
      redirect_to post_path, notice: 'Post successfully updated.'
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
