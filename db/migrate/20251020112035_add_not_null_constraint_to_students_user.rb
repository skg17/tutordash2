class AddNotNullConstraintToStudentsUser < ActiveRecord::Migration[8.0]
  def change
    change_column_null :students, :user_id, false
  end
end
