class AddHighlightsViewToUsers < ActiveRecord::Migration
  def change
    add_column :users, :highlights_view, :string, default: "new"
  end
end
