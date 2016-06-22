class AddHighlightsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :highlights, :string
  end
end
