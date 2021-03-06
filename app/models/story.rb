class Story < ActiveRecord::Base
  
  YT_LINK_FORMAT = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates         :first_name, :last_name, :street_address, :city, :state, 
                    :zip, presence: true 
  validates         :video_link, format: { with: YT_LINK_FORMAT, multiline: true }, :if => :video_link?
  validates         :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }

  before_validation :link_validation, :on => [:create, :update], :if => :video_link?
  geocoded_by :geocode_search
  after_validation :geocode, :if => :zip_changed?

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  private
    def link_validation
      uid = video_link.match(YT_LINK_FORMAT)
      self.video_uid = uid[2] if uid && uid[2]
     
      if self.video_uid.to_s.length != 11
        self.errors.add(:video_link, 'is invalid.')
        false
      end
    end

    def geocode_search
      begin
        self.zip.to_region  
      rescue ArgumentError
        "Chicago, IL"
      end
    end
end
