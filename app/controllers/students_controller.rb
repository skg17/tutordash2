class StudentsController < ApplicationController
    before_action :set_student, only: [ :show, :edit, :update, :destroy ]

    def index
        @students = current_user.students.all.order(:name)
    end

    def show
        all_lessons = @student.lessons.sort_by(&:date).reverse
        @upcoming_lesson = @student.lessons.find { |l| l.date && l.date > Time.current }
        @recent_lessons = all_lessons.select { |l| l.date && l.date <= Time.current }
                                        .first(5)
        @display_lessons = ([ @upcoming_lesson ] + @recent_lessons).compact.uniq
    end

    def new
        @student = current_user.students.new()
    end

    def create
        @student = current_user.students.new(student_params)
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
        @student.destroy
        redirect_to students_path, notice: "Student deleted successfully."
    end

    private

    def set_student
        @student = current_user.students.includes(:lessons).find(params[:id])
    end

    def student_params
        permitted_params = params.require(:student).permit(:name, :year, :subjects, :current, :rate, :grade, :target, :parent_name, :email, :phone)

        if permitted_params[:subjects].is_a?(String)
            permitted_params[:subjects] = permitted_params[:subjects].split(",").map(&:strip).reject(&:blank?)
        end

        permitted_params
    end
end
