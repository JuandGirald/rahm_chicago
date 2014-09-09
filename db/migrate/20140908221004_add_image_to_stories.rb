class AddImageToStories < ActiveRecord::Migration
  def self.up
    add_attachment :stories, :image
  end

  def self.down
    remove_attachment :stories, :image
  end
end
