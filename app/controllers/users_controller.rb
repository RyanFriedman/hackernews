class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to :action => 'show', :id => @book
  end
  
  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :bid_amount, :biddable_type, :biddable_id)
    end
end