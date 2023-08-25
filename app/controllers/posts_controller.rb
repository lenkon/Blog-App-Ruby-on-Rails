class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id].to_i)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    new_post = Post.new
    respond_to do |f|
      f.html { render :new, locals: { new_post: } }
    end
  end
end
