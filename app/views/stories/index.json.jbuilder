json.array!(@stories) do |story|
  json.extract! story, :id, :first_name, :last_name, :street_address, :city, :state, :email, :zip, :telephone, :story_body, :photo_id
  json.url story_url(story, format: :json)
end
