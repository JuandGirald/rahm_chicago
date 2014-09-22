class Story < ActiveRecord::Base
  
  YT_LINK_FORMAT = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates         :first_name, :last_name, :street_address, :city, :state, 
                    :zip, presence: true 
  validates         :link, format: { with: YT_LINK_FORMAT, multiline: true }, :if => :link?
  validates         :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX }
  before_validation :link_validation, :on => [:create, :update], :if => :link?

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  private
    def link_validation
      uid = link.match(YT_LINK_FORMAT)
      self.video_uid = uid[2] if uid && uid[2]
     
      if self.video_uid.to_s.length != 11
        self.errors.add(:link, 'is invalid.')
        false
      end
    end
end
