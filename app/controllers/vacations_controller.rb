class VacationsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def get_vacations_for_status
    @vacations = Vacation.where("status = ? and user_id = ?", params[:status].to_i, current_user.id).order(:vacation_date)
    render json: {msg: "success", vacations: @vacations}
  end


  def create
    @vacation = Vacation.new(vacation_params)
    @vacation.status = 1
    @vacation.user_id = current_user.id

    if @vacation.save
      render json: {status: 'success', message: "vacation saved", vacation: @vacation}
    else
      render json: {status: "fail", message: "vacation not saved"}
    end

  end

  def update_status
    @vacation = Vacation.find_by("id = ? and user_id = ?", params[:vacation_id].to_i, current_user.id)

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
    @vacation = Vacation.find_by("id = ? and user_id = ?", params[:vacation][:id], current_user.id)
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
    delete_vacations_for_user
    flash[:success] = "All Vacations Cleared"
    redirect_to root_path
  end

  def set_defaults
    delete_vacations_for_user
    Vacation.set_default_values(current_user.id)
    flash[:success] = "Default values loaded"
    redirect_to root_path
  end

  private

  def delete_vacations_for_user
    Vacation.delete_all "user_id = #{current_user.id}"
  end

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