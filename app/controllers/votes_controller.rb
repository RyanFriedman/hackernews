class VotesController < ApplicationController
  
  def create
    vote = current_user.votes.build(vote_params).save!
    redirect_to :back
  end 
  
  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:voteable_type, :voteable_id)
    end
end