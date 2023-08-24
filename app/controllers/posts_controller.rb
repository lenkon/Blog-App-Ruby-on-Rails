class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id].to_i)
  end

  def show; end
end
