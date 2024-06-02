class CommentsController < ApplicationController
  before_action :find_post

  # def index
  #   @comments = Comment.where(post_id: @post.id)
  # end

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post)
    else
      puts @comment.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    @comment.destroy

    redirect_to post_path, status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
