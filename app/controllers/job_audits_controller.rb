class JobAuditsController < ApplicationController
  before_action :set_job_audit, only: [:show, :update, :destroy]

  # GET /job_audits
  def index
    @job_audits = JobAudit.all

    render json: @job_audits
  end

  # GET /job_audits/1
  def show
    render json: @job_audit
  end

  # POST /job_audits
  def create
    @job_audit = JobAudit.new(job_audit_params)

    if @job_audit.save
      render json: @job_audit, status: :created, location: @job_audit
    else
      render json: @job_audit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /job_audits/1
  def update
    if @job_audit.update(job_audit_params)
      render json: @job_audit
    else
      render json: @job_audit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /job_audits/1
  def destroy
    @job_audit.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_audit
      @job_audit = JobAudit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_audit_params
      params.require(:job_audit).permit(:job_id, :time_sent, :recipient, :subject, :content)
    end
end
