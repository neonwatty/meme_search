class CreateImagePaths < ActiveRecord::Migration[7.2]
  def change
    create_table :image_paths do |t|
      t.string :img_path, limit: 300
      t.timestamps
    end
    add_index :image_paths, :img_path, unique: true
  end
end
