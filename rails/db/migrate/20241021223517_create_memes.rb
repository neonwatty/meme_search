class CreateMemes < ActiveRecord::Migration[7.2]
  def change
    create_table :memes do |t|
      t.string :filename
      t.string :description

      t.timestamps
    end
      add_index :memes, :filename, unique: true
  end
end
