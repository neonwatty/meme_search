class CreateTagNames < ActiveRecord::Migration[7.2]
  def change
    create_table :tag_names do |t|
      t.string :name

      t.timestamps
    end
  end
end
