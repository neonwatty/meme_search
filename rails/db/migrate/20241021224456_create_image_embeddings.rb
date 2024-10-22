class CreateImageEmbeddings < ActiveRecord::Migration[7.2]
  def change
    create_table :image_embeddings do |t|
      t.references :image_core, foreign_key: true, index: true, null: false
      t.vector :image_embedding, limit: 384

      t.timestamps
    end
  end
end
