class LessonsController < ApplicationController
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
            render :new
        end
   end

   def destroy
       Lesson.find(params[:id]).destroy
       redirect_to lessons_path
   end   

   private

   def lesson_params
        params.require(:lesson).permit(:name, :date, :duration, :paid, :subject, :homework)
   end
end