class CreateReaders < ActiveRecord::Migration[5.2]
  def change
    create_table :readers do |t|
      t.string :title
      t.datetime :published
      t.text :description
      t.string :url
      t.integer :feed_id

      t.timestamps
    end
  end
end
