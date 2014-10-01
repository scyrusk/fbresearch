# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#  fb_profile :string(255)
#

class Author < ActiveRecord::Base
  has_many :author_publication_links
  has_many :publications, through: :author_publication_links
  mount_uploader :image, ImageUploader

  validates_presence_of :name

  def self.create_author name, image, fb_profile
    a = Author.find_or_initialize_by(name: name)
    a.remote_image_url = image if image
    a.fb_profile = fb_profile if fb_profile
    a.save
    return a
  end

  def self.get_for_names *names
    anames = "(#{names.map { |n| "'#{n}'" }.join(",")})"
    Author.where("name IN #{anames}")
  end
end