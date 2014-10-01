class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)

    respond_to do |format|
      @errors = @vote.save
      format.js
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(
        :summary_id,
        :worker_id,
        :hit_id,
        :assignment_id
      )
    end
end
