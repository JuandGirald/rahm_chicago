module ApplicationHelper

  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    iframe = %Q{<iframe title='YouTube video player' width='400' height='250' 
              src='http://www.youtube.com/embed/#{ youtube_id }' frameborder='0' allowfullscreen></iframe>}
    iframe.html_safe
  end
end
