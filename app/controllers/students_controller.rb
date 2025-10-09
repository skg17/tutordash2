class StudentsController < ApplicationController
   def index
       @students = Student.all
   end

   def new
        @student = Student.new()
   end

   def create
        @student = Student.new(student_params)
        if @student.save
           redirect_to students_path
        else
            render :new
        end
   end

   def destroy
       Student.find(params[:id]).destroy
       redirect_to students_path
   end   

   private

   def student_params
        permitted_params = params.require(:student).permit(:name, :year, :subjects, :current, :rate, :grade, :target)

        # Handles list of subjects separated by commas
        if permitted_params[:subjects].is_a?(String)
            permitted_params[:subjects] = permitted_params[:subjects].split(',').map(&:strip).reject(&:blank?)
        end

        permitted_params
   end
end
