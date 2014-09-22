class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :stories, :link, :video_link
  end
end
