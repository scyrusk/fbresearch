class SummariesController < ApplicationController
  before_action :allow_iframe

  def new
    pid = params[:publication_id]
    if pid.nil?
      redirect_to :root
    else
      @assignment_id = params[:assignmentId]
      @unaccepted = @assignment_id.nil? || @assignment_id == "ASSIGNMENT_ID_NOT_AVAILABLE"
      unless @unaccepted
        @worker_id = params[:workerId]
        @submit_to = "#{params[:turkSubmitTo] || ""}/mturk/externalSubmit"
        @hit_id = params[:hitId]
      end
      @summary = Summary.new(
        publication_id: pid,
        assignment_id: @assignment_id,
        worker_id: @worker_id,
        hit_id: @hit_id
      )
    end
  end

  def create
    @summary = Summary.new(summary_params)

    respond_to do |format|
      @errors = !@summary.save
      unless @summary.save
        @errors = @summary.errors
      end
      format.js
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def summary_params
      params.require(:summary).permit(
        :publication_id,
        :content,
        :worker_id,
        :hit_id,
        :assignment_id
      )
    end

    def allow_iframe
      response.headers.except! 'X-Frame-Options'
    end
end