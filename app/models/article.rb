class Article < ActiveRecord::Base
  has_many  :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }

  has_many :taggings
  has_many :tags, :through => :taggings

  scope :tag_with, lambda{ |tag_name| joins(:tags).where("tags.name = ?", tag_name) }
  scope :latter_than, lambda{ |time| joins(:taggings).where("taggings.created_at > ?", time) }

  # def self.tag_with(tag_name)
  #   Tag.find_by(name: tag_name).try(:articles)
  # end
end
