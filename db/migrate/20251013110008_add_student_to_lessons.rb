class AddStudentToLessons < ActiveRecord::Migration[8.0]
  def change
    add_reference :lessons, :student, null: true, foreign_key: true
  end
end
