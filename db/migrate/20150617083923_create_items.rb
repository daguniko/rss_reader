class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :link
      t.date :entrydate
      t.string :description
      t.text :related_articles

      t.timestamps null: false
    end
  end
end
