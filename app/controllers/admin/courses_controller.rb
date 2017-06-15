class Admin::CoursesController < Admin::ApplicationController

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = "Course has been created."
      redirect_to @course
    else
      flash.now[:alert] = "Course has not been created."
      render "new"
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = "Course has been deleted."
    redirect_to courses_path
  end

  private
  def course_params
    params.require(:course).permit(:name, :description)
  end
end
