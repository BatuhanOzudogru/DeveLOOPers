class CreateJoinTableArticleTag < ActiveRecord::Migration[7.1]
  def change
    create_join_table :articles, :tags do |t|
      # t.index [:article_id, :tag_id]
      # t.index [:tag_id, :article_id]
    end
  end
end
