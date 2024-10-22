class CreateImageCores < ActiveRecord::Migration[7.2]
  def change
    create_table :image_cores do |t|
      t.references :image_path, foreign_key: true, index: true, null: false
      t.string :image_name, limit: 100
      t.string :image_description, limit: 500

      t.timestamps
    end
  end
end
