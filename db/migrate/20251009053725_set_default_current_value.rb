class SetDefaultCurrentValue < ActiveRecord::Migration[8.0]
  def change
    change_column_default :students, :current, true
  end
end
