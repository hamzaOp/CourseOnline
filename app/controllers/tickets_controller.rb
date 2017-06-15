class TicketsController < ApplicationController
  before_action :set_course
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  def new
    @ticket = @course.tickets.build
    authorize @ticket, :create?
    3.times { @ticket.attachments.build }
  end

  def create
    @ticket = @course.tickets.build(ticket_params)
    @ticket.author = current_user
    authorize @ticket, :create?
    if @ticket.save
      flash[:notice] = "Ticket has been created."
      redirect_to [@course, @ticket]
    else
      flash.now[:alert] = "Ticket has not been created."
      render "new"
    end
  end

  def show
    authorize @ticket, :show?
  end

  def edit
    authorize @ticket, :update?
  end

  def update
    authorize @ticket, :update?
    if @ticket.update(ticket_params)
      flash[:notice] = "Ticket has been updated."
      redirect_to [@course, @ticket]
    else
      flash.now[:alert] = "Ticket has not been updated."
      render "edit"
    end
  end

  def destroy
    authorize @ticket, :destroy?
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted."
    redirect_to @course
  end

  private
  def ticket_params
    params.require(:ticket).permit(:name, :description, attachments_attributes: [:file, :file_cache])
  end
  def set_course
    @course = Course.find(params[:course_id])
  end
  def set_ticket
    @ticket = @course.tickets.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The ticket you were looking for could not be found."
    redirect_to @course
  end
end
