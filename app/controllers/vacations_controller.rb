class VacationsController < ApplicationController
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
    @vacation = Vacation.find_by(id: params[:vacation_id].to_i)
    if @vacation && (@vacation.status != params[:vacation_id].to_i)
      @vacation.status = params[:status].to_i
      if @vacation.save
        render json: {msg: "status updated", status: "success", vacation: @vacation}
      else
        render json: {msg: "status not updated", status: "failed"}
      end
    else
      render json: {msg: "vacation not found", status: "failed"}
    end
  end

  def update
    @vacation = Vacation.find_by(id: params[:vacation][:id])
    if @vacation
      @vacation.description = params[:vacation][:description]
      @vacation.vacation_date = params[:vacation][:vacation_date]
      if @vacation.save
        render json: {msg: "status updated", status: "success", vacation: @vacation}
      else
        render json: {msg: "status not updated", status: "failed"}
      end
    else
      render json: {msg: "vacation not found", status: "failed"}
    end
  end


  def reset
    Vacation.delete_all
    flash[:danger] = "All Vacations Cleared"
    redirect_to root_path

  end

  private

  def vacation_params
    params.require(:vacation).permit(:vacation_date, :description)
  end
end