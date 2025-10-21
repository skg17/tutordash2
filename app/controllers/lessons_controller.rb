class LessonsController < ApplicationController
    # Ensure set_students runs for edit/update as well for error re-rendering
    before_action :set_students, only: [:new, :create, :edit, :update] 
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]

    def index
        status_order = Arel.sql("CASE WHEN date > NOW() THEN 0 ELSE 1 END")

        @lessons = current_user.lessons
                        .includes(:student)
                        .order(status_order)
                        .order(date: :asc)
    end

    def new
        @lesson = current_user.lessons.new() 
    end

    def create
        @lesson = Lesson.new(lesson_params)

        # Note: Student must be found before validation/save, otherwise the save might fail.
        student = current_user.students.find_by(id: @lesson.student_id)
        
        unless student
            # If the student is not found in the current user's collection
            flash.now[:alert] = "The selected student could not be found or does not belong to your account."
            # Reload necessary data for re-rendering :new
            @students = current_user.students.all 
            render :new, status: :unprocessable_entity and return
        end

        if @lesson.save
           redirect_to lessons_path, notice: 'Lesson scheduled successfully.'
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def edit; end

    def update
        if @lesson.update(lesson_params)
            redirect_to @lesson, notice: 'Lesson was successfully updated.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @lesson.destroy
        redirect_to lessons_path, notice: 'Lesson deleted successfully.'
    end

    def update_subjects
      @student = current_user.students.find_by(id: params[:student_id])
      
      # Prepare lesson instance
      @lesson = Lesson.new(student_id: @student.id) 
      
      render partial: 'lessons/subject_select', locals: { form: nil, lesson: @lesson }
    end

    def show; end


    private

    def set_students
      @students = current_user.students.all
    end

    def set_lesson
        @lesson = current_user.lessons.includes(:student).find(params[:id]) 
    end

    def lesson_params
        params.require(:lesson).permit(:student_id, :date, :duration, :paid, :subject, :homework)
    end
end