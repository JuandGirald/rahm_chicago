class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :email
      t.string :zip
      t.string :telephone
      t.text :story_body
      t.boolean :photo_id

      t.timestamps
    end
  end
end
