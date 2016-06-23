class PostsController < ApplicationController

  before_action :require_login

  def new
    @post = Post.new
    render :new
  end

  def index
    @posts = Post.all.order(:post_date)
    render :index
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def create
  	post_params = params.require(:post).permit(:title, :description, :image, :period_id, :post_date)
    @post = Post.create(post_params)
    @user = current_user
    @user.posts << @post
    redirect_to '/posts'

    periods = Period.all
    periods.each do |period| 
      if period.start_time <= @post.post_date && period.end_time >= @post.post_date
        period.posts.push(@post) 
     end
   end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
  	@post = Post.find(params[:id])
    post_params = params.require(:post).permit(:title, :description, :image, :user_id, :period_id, :post_date)
    
     periods = Period.all
     periods.each do |period| 
       if period.start_time <= @post.post_date && period.end_time >= @post.post_date
         period.posts.push(@post) 
      end
    end

    if @post.update_attributes(post_params)
  	redirect_to post_path(@post)
    #   render edit_post_path
    end
  end

  def destroy
  	@post = Post.find(params[:id])
  	@post.destroy
    redirect_to '/posts'
  end

end
