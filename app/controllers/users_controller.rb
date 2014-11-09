class UsersController < ApplicationController
  def index
    @users = User.order("karma DESC").limit(50)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Your changes have been saved!"
    end
    redirect_to :action => 'show', :id => @user
  end
  
  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :about, :bid_amount, :biddable_type, :biddable_id)
    end
end