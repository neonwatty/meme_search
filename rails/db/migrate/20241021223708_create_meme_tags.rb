class CreateMemeTags < ActiveRecord::Migration[7.2]
  def change
    create_table :meme_tags do |t|
      t.references :meme, foreign_key: true, index: true, null: false
      t.references :tag_type, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
