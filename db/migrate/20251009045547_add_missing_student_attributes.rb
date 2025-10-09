class AddMissingStudentAttributes < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :year, :integer
    add_column :students, :current, :boolean # Is the student still taking lessons?
    add_column :students, :subjects, :string, array: true, default: [] # Use arrays to support multiple subjects per student
    add_column :students, :rate, :decimal, precision: 8, scale: 2 # Round rate to 2 d.p. as it's a currency value
    add_column :students, :grade, :string # Current working grade
    add_column :students, :target, :string # Student's target grades
  end
end
