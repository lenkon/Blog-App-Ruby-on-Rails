class LikesController < ApplicationController
  def new; end

  def create
    @user_id = current_user.id
    @post = Post.find(params[:post_id])
    @like = Like.new(post_id: @post.id, author_id: @user_id)
    @like.author = current_user
    @like.post = Post.find(@post.id)
    @like.save

    redirect_to user_post_path(current_user, @post.id)
  end
end
