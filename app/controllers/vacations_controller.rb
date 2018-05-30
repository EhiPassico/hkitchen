class VacationsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def get_vacations_for_status
    @vacations = Vacation.where("status = ?", params[:status].to_i).order(:vacation_date)
    render json: {msg: "success", vacations: @vacations}
  end


  def create
    @vacation = Vacation.new(vacation_params)
    @vacation.status = 1

    if @vacation.save
      render json: {status: 'success', message: "vacation saved", vacation: @vacation}
    else
      render json: {status: "fail", message: "vacation not saved"}
    end

  end

  def update_status
    @vacation = Vacation.find_by("id = ?", params[:vacation_id].to_i)

    if @vacation && (@vacation.status != params[:status].to_i) && is_valid_status?(params[:status])
      if @vacation.save
        render json: {msg: "status updated", status: "success", vacation: @vacation}
      else
        render json: {msg: "status not updated", status: "fail"}
      end
    else
      render json: {msg: "vacation not found", status: "fail"}
    end
  end

  def update
    @vacation = Vacation.find_by("id = ?", params[:vacation][:id])
    if @vacation

      if @vacation.update_attributes(vacation_params)
        render json: {msg: "status updated", status: "success", vacation: @vacation}
      else
        render json: {msg: "status not updated", status: "fail"}
      end
    else
      render json: {msg: "vacation not found", status: "fail"}
    end
  end


  def reset
    Vacation.delete_all
    flash[:success] = "All Vacations Cleared"
    redirect_to root_path
  end

  def set_defaults
    Vacation.delete_all
    Vacation.set_default_values
    flash[:success] = "Default values loaded"
    redirect_to root_path
  end

  private

  def is_valid_status?(status)
    if status == 1 || status == 2 || status == 3
      @vacation.status = status
      return true
    else
      return false
    end
  end

  def vacation_params
    params.require(:vacation).permit(:vacation_date, :description)
  end
end