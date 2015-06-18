class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :link
      t.date :entrydate
      t.string :description
      t.text :related_articles
      t.text :tfidf
      t.text :counts

      t.timestamps null: false
    end
  end
end
