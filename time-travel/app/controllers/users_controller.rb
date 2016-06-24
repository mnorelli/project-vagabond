class UsersController < ApplicationController
  
  before_action :require_login, :only => [:edit, :show]

  # def home
  #   render :index
  # end

  def new
  	@user = User.new
  	render :new
  end

   def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :email_confirmation, :password, :password_confirmation, :image)
    @user = User.new(user_params)
    if @user.save
      login(@user) # <-- login the user
      redirect_to "/users/#{@user.id}" # <-- go to show
    else
      redirect_to '/signup', flash: {error: @user.errors.full_messages.to_sentence}
    end
  end

  def show
    if current_user == admin_user
      @users = User.all
      @user = User.find(admin_user.id)
      @posts = Post.where(user_id: admin_user.id)
      @periods = Period.where(user_id: admin_user.id)
      render :admin
    else
      @user = User.find(params[:id])
      @posts = Post.where(user_id: params[:id])
      @periods = Period.where(user_id: params[:id])
      render :show
    end
  end


  def edit
  	@user = User.find(params[:id])
    if current_user.id != @user.id 
      redirect_to '/users/' + @user.id.to_s
    else
  	  render :edit
    end
  end


  def settings
    @user = User.find(params[:id])
    if current_user.id != @user.id 
      redirect_to '/users/' + @user.id.to_s
    else
      render :settings
    end
  end

  def update
  	@user = User.find(params[:id])
  	user_params= params.require(:user).permit(:first_name, :last_name, :email, :email_confirmation, :password, :password_confirmation, :image)
  	if User.update(@user.id, user_params)
  		redirect_to "/users/#{@user.id}"
  	else
  		render :edit
  	end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy    
    redirect_to '/'
    # do not forget to add dependent: :destroy to user model so that posts
    # associated with user are deleted, along with user.
  end
end
