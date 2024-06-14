class CreateActionTextRichTexts < ActiveRecord::Migration[7.1]
    def change
      create_table :action_text_rich_texts do |t|
        t.string :name, null: false
        t.text :body
        t.string :record_type, null: false
        t.bigint :record_id, null: false
        t.timestamps null: false
      end
  
      add_index :action_text_rich_texts, [:record_type, :record_id, :name], unique: true, name: 'index_action_text_rich_texts_uniqueness'
    end
  end
  