class ChangeDateBackToDatetimeType < ActiveRecord::Migration[8.0]
  def change
    change_column :lessons, :date, :datetime
  end
end
