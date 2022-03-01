class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  # association
  has_many :tickets

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # enum refers to the Ruby class that we’re using
  # role: is the attribute that we’re going to treat as an enum.
  # [:user, :admin] are the names we’re using to reference the user role.
  enum role: [:user, :admin]
  

  # Set a default role for new users by using after_initialize callback on your User model 
  after_initialize :set_default_role, :if => :new_record? 
  
  # a ||= b is a conditional assignment operator.
  def set_default_role
    self.role ||= :user
  end


  has_one_attached :avatar

  after_commit :add_default_avatar, on: %i[create update]

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize_to_limit: [120, 120]).processed 
    else
      '/default_profile.jpg'
    end
  end

  private
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_profile.jpg'
          )
        ), 
        filename: 'default_profile.jpg',
        content_type: 'image/jpg'
        )
    end
  end
end
