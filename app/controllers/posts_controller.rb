class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: %i[edit update destroy]

    def index
      @q = Post.ransack(params[:q])
      @posts = @q.result.order(created_at: :DESC).page(params[:page]).per(5)
    end

    def new
      @post = Post.new
    end

    def create
      @post = current_user.posts.new(posts_params)
      if @post.save
        render_turbo_stream(
          'prepend',
          'user_posts',
          'posts/post',
          { post: @post }
        )
      else
        render_turbo_stream(
          'replace',
          'remote_modal',
          'shared/turbo_modal',
          {
            form_partial: 'posts/new_post_modal',
            modal_title: "Add Post"
          }
        )
      end
    end

    def edit; end

    def update
      if @post.update(posts_params)
        render_turbo_stream(
          'replace',
          "post_#{@post.id}",
          'posts/post',
          { post: @post }
        )
      else
        render_turbo_stream(
          'replace',
          'remote_modal',
          'shared/turbo_modal',
          {
            form_partial: 'posts/new_post_modal',
            modal_title: "Edit Post"
          }
        )
      end
    end

    def destroy
      @post.destroy
      render_turbo_stream(
        'remove',
        "post_#{@post.id}"
      )
    end
  
    private

    def set_post
      @post = current_user.posts.find(params[:id])
    end
  
    def posts_params
      params.require(:post).permit(:title, :content)
    end
  end
  