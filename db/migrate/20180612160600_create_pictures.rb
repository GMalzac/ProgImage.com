class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :format
      t.time :created_at
      t.integer :width
      t.integer :height
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
