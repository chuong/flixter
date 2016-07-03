class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_for_current_course, only: [:show]

  def new
  end

  private

  def require_enrollment_for_current_course
    current_course = current_lesson.section.course
    if !current_user.enrolled_in?(current_course)
      redirect_to course_url(current_lesson.section.course), alert: 'Must Enroll to View Lessons!'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

end
