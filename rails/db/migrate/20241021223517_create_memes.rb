class CreateMemes < ActiveRecord::Migration[7.2]
  def change
    create_table :memes do |t|
      t.string :filename, limit: 100
      t.string :description, limit: 500

      t.timestamps
    end
    add_index :memes, :filename, unique: true
  end
end
