class StudentsController < ApplicationController
    # Sets @student for all actions that need it: show, edit, update, and destroy.
    before_action :set_student, only: [:show, :edit, :update, :destroy]

    def index
        @students = Student.all
    end

    def show
        # @student is set by before_action
        all_lessons = @student.lessons.sort_by(&:date).reverse
        @upcoming_lesson = @student.lessons.find { |l| l.date && l.date > Time.current }
        @recent_lessons = all_lessons.select { |l| l.date && l.date <= Time.current }
                                        .first(5)
        @display_lessons = ([@upcoming_lesson] + @recent_lessons).compact.uniq
    end

    def new
        @student = Student.new()
    end

    def create
        @student = Student.new(student_params)
        if @student.save
           redirect_to students_path, notice: "Student #{@student.name} created successfully."
        else
            render :new
        end
    end

    def edit
        # @student is already set by the before_action
    end

    def update
        if @student.update(student_params)
            redirect_to student_path(@student), notice: "Student #{@student.name} updated successfully."
        else
            render :edit
        end
    end

    def destroy
        # @student is already set by the before_action
        @student.destroy
        redirect_to students_path, notice: "Student deleted successfully."
    end

    private
    
    def set_student
        # We keep includes(:lessons) here since the show action needs it for efficiency.
        @student = Student.includes(:lessons).find(params[:id])
    end

    def student_params
        permitted_params = params.require(:student).permit(:name, :year, :subjects, :current, :rate, :grade, :target, :parent_name, :email, :phone)

        # Handles list of subjects separated by commas
        if permitted_params[:subjects].is_a?(String)
            permitted_params[:subjects] = permitted_params[:subjects].split(',').map(&:strip).reject(&:blank?)
        end

        permitted_params
    end
end