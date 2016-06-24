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
  		if current_user.id != @period.user_id 
        redirect_to '/periods/' + @period.id.to_s
      else
        render :edit
      end
  	end

  	def update
  		@period = Period.find(params[:id])
    	period_params = params.require(:period).permit(:title, :description, :image, :start_time, :end_time, :image)

      @posts = Post.all
      @posts.each do |post|
        if @period.start_time <= post.post_date && @period.end_time >= post.post_date
          @period.posts.push(post)
        end
      end
      
    	if @period.update_attributes(period_params)
  			redirect_to '/periods/'+params[:id].to_s
    	end
  	end

  	def destroy
  		@period = Period.find(params[:id])

      # remove user's posts on this period
      id = @current_user.id
      user_posts = @period.posts.where({user_id:id})
      if user_posts.count > 0
        user_posts.each do |post|
          post.destroy
        end
      else
        # byebug
        @period.posts.delete(user_posts)
      end

      # remove association(s)
      joins = PeriodPost.where({period_id:@period.id})
      if joins.count > 0
        joins.each do |join|
          join.destroy
        end
      end

      #remove the period
      @period.destroy
      redirect_to '/periods'
    end

    
end
