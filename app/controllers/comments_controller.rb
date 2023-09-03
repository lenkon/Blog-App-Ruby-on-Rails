class CommentsController < ApplicationController
  def new
    new_comment = Comment.new
    respond_to do |f|
      f.html { render :new, locals: { new_comment: } }
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(post_id: @post.id, author_id: current_user.id, text: comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:success] = 'Comment saved successfully.'
      redirect_to user_post_path(current_user, @post.id)
    else
      new_comment = Comment.new
      flash.now[:error] = 'Error: Fail to save comment.'
      render :new, locals: { new_comment: }
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    Comment.destroy(params[:id])
    post.comments_counter -= 1
    post.save
    redirect_to user_posts_path(current_user.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
