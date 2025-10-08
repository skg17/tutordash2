class ChangeDateVariableType < ActiveRecord::Migration[8.0]
  def change
    change_column :lessons, :date, :date
  end
end
