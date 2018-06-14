class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :pictures, :url, :source
  end
end
