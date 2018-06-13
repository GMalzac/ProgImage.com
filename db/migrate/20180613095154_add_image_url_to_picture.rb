class AddImageUrlToPicture < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :image_url, :string
  end
end
