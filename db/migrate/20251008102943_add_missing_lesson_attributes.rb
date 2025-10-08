class AddMissingLessonAttributes < ActiveRecord::Migration[8.0]
  def change
    add_column :lessons, :duration, :float
    add_column :lessons, :subject, :string
    add_column :lessons, :paid, :boolean
    add_column :lessons, :homework, :string
  end
end
