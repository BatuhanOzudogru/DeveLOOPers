class AddVoteCountToArticle < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :vote_count, :integer, default: 0
  end
end
