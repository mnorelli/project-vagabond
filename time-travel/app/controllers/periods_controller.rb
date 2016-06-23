class PeriodsController < ApplicationController

before_action :require_login, :except => [:index, :show]

	def index
		@periods = Period.all.order(start_time: :desc)
		render :index
	end

	def show
		@period = Period.find(params[:id])
    @posts = @period.posts
    render :show
	end

  def new
    @period = Period.new
    render :new
  end

	def create
  		period_params = params.require(:period).permit(:name, :description, :image, :start_time, :end_time)
  		@period = Period.create(period_params)
      @user = current_user
      @user.periods << @period
      redirect_to '/periods'
  	end

  	def edit
  		@period = Period.find(params[:id])
  		if current_user.id != params[:id] 
        redirect_to '/periods/' + @period.id.to_s
      else
        render :edit
      end
  	end

  	def update
  		@period = Period.find(params[:id])
    	period_params = params.require(:post).permit(:title, :description, :image, :user_id, :period_id, :post_date)

      @posts = Post.all
      @posts.each do |post|
        if @period.start_time <= post.post_date && @period.end_time >= post.post_date
          @period.posts.push(post)
        end
      end
      
      redir
    	if @period.update_attributes(period_params)
  			redirect_to '/periods/:id'
    	end
  	end

  	def destroy
  		@period = Period.find(params[:id])
  		if current_user.id != @user.id 
        redirect_to '/periods/:id'
      else
        @period.destroy
      end
    end
    
end
