class RemoveHighlightsViewFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :highlights_view, :string
  end
end
