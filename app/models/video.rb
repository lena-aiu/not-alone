class Video < ApplicationRecord
  has_one_attached :clip
    validates :title, presence: true
    validates :description, presence: true
    #validates :text, presence: true
end
