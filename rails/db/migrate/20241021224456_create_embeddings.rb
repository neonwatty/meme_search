class CreateEmbeddings < ActiveRecord::Migration[7.2]
  def change
    create_table :embeddings do |t|
      t.references :meme, foreign_key: true, index: true, null: false
      t.vector :snippet_embedding, limit: 384

      t.timestamps
    end
  end
end
