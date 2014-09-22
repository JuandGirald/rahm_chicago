class AddBlogLinkToStories < ActiveRecord::Migration
  def change
    add_column :stories, :blog_link, :string
  end
end
