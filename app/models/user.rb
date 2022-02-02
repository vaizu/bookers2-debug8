class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :followers, class_name: "relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers_list, through: :followers, source: :relationship

  has_many :followeds, class_name: "relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followeds_list, through: :followeds, source: :relationship

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  validates :introduction, length: {maximum: 50}

  def get_profile_image(size)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize: size).processed
  end
end
