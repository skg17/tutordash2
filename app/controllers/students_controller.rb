class StudentsController < ApplicationController
   def index
       @students = Student.all
   end

   def new
        @student = Student.new()
   end

   def create
        @student = Student.new(lesson_params)
        if @student.save
           redirect_to root_url
        else
            render :new
        end
   end

   def destroy
       Student.find(params[:id]).destroy
       redirect_to root_url
   end   

   private

   def student_params
        params.require(:student).permit(:name, :year, :subjects, :current, :rate, :grade, :target)
   end
end
