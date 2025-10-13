class AddNotNullConstraintToLessonsStudentId < ActiveRecord::Migration[8.0]
  def change
    change_column_null :lessons, :student_id, false
  end
end
