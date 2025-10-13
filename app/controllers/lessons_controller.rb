class LessonsController < ApplicationController
    # Call set_students before the new and create actions
    before_action :set_students, only: [:new, :create]
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]

    def index
        # We use Arel/SQL to sort by two criteria:
        # 1. 'is_completed': 1 if completed (past date), 0 if upcoming (future date).
        #    Sorting by this ASC (0 then 1) pushes completed lessons to the bottom.
        # 2. 'date': Orders upcoming lessons chronologically, and past lessons chronologically.
        
        status_order = Arel.sql("CASE WHEN date > NOW() THEN 0 ELSE 1 END")

        @lessons = Lesson.unscoped
                        .includes(:student) # Keep this for performance
                        .order(status_order)
                        .order(date: :asc) # Sorts by ascending date (oldest upcoming first)
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

    def edit
        # @lesson is now set by the before_action :set_lesson
    end

    def update
        if @lesson.update(lesson_params)
            redirect_to @lesson, notice: 'Lesson was successfully updated.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @lesson.destroy
        redirect_to lessons_path
    end

    def update_subjects
      # Find the student based on the ID passed from the form
      @student = Student.find_by(id: params[:student_id])
      
      # Prepare a lesson instance to pass to the partial
      # We use .new to pass a non-persisted lesson to the partial
      @lesson = Lesson.new(student_id: @student.id) 
      
      # Render the partial within the 'lesson_subject_field' Turbo Frame
      # This replaces the content of the frame in the view
      render partial: 'lessons/subject_select', locals: { form: nil, lesson: @lesson }
    end

    def show
        # @lesson is now set by the before_action :set_lesson
    end


    private

    def set_students
      @students = Student.all
    end

    def set_lesson
        @lesson = Lesson.includes(:student).find(params[:id]) 
    end

    def lesson_params
        params.require(:lesson).permit(:student_id, :date, :duration, :paid, :subject, :homework)
    end
end