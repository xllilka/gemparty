class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user, optional: true
    validates :title, presence: true
    # validates :name, optional: true => nil 값이어도 에러가 나지 않음
    mount_uploader :image, ImageUploader

end



# carrierwave로 이미지 업로드 해오기
