class ReportsController < ApplicationController
  def index
    @reports = Report.includes(:user)
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id

    if @report.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])

    if @report.update(grade_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    redirect_to root_path
  end

  private

  def report_params
    params.require(:report).permit(:title, :description)
  end

  def grade_params
    params.require(:report).permit(:grade)
  end
end
