class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, limit:140
      t.text :content
      t.integer :status, default:0

      t.timestamps
    end
  end
end
