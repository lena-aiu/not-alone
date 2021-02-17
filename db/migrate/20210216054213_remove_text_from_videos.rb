class RemoveTextFromVideos < ActiveRecord::Migration[6.0]
  def change
    remove_column :videos, :text, :string
  end
end
