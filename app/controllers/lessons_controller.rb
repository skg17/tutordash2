class LessonsController < ApplicationController
    # Call set_students before the new and create actions
    before_action :set_students, only: [:new, :create] 

    def index
        @lessons = Lesson.all
    end

    def new
        @lesson = Lesson.new()
    end

    def create
        @lesson = Lesson.new(lesson_params)
        if @lesson.save
           redirect_to lessons_path
        else
            # If save fails (validation errors), we render :new
            # The before_action ensures @students is available when :new is rendered
            render :new, status: :unprocessable_entity 
        end
    end

    def destroy
        Lesson.find(params[:id]).destroy
        redirect_to lessons_path
    end   

    private

    # Load all students
    def set_students
      @students = Student.all
    end

    def lesson_params
        params.require(:lesson).permit(:student_id, :date, :duration, :paid, :subject, :homework)
    end
end