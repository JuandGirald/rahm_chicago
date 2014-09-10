class AddVideoUidToStories < ActiveRecord::Migration
  def change
    add_column :stories, :video_uid, :string
  end
end
