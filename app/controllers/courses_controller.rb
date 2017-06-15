class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update]
  def index
    @courses = policy_scope(Course)
  end





  def show
    authorize @course, :show?
  end

  def edit
    authorize @course, :update?
  end

  def update
    authorize @course, :update?
    if @course.update(course_params)
      flash[:notice] = "Course has been updated."
      redirect_to @course
    else
      flash.now[:alert] = "Course has not been updated."
      render "edit"
    end
  end



  private
  def set_course
    @course = Course.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The course you were looking for could not be found."
    redirect_to courses_path
  end
  def course_params
    params.require(:course).permit(:name, :description)
  end
end
