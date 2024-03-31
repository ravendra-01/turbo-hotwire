class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def like
    @like = @post.likes.new(user_id: like_params[:user_id])
    if @like.save
      render_turbo_stream(
        'replace',
        "like_post_#{@post.id}",
        'posts/like',
        { post: @post, icon: "bi bi-hand-thumbs-up-fill", action: post_dislike_path }
      )
    end
  end
  
  def dislike
    @like = @post.likes.find_by(user_id: like_params[:user_id])
    if @like.destroy
      render_turbo_stream(
        'replace',
        "like_post_#{@post.id}",
        'posts/like',
        { post: @post, icon: "bi bi-hand-thumbs-up", action: post_like_path }
      )
    end
  end

  private
  def set_post
    @post = Post.find(like_params[:post_id])
  end

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
