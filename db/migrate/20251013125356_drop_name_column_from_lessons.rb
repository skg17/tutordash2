class DropNameColumnFromLessons < ActiveRecord::Migration[8.0]
  def change
    remove_column :lessons, :name
  end
end
