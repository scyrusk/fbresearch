# == Schema Information
#
# Table name: author_publication_links
#
#  id             :integer          not null, primary key
#  author_id      :integer
#  publication_id :integer
#  order          :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class AuthorPublicationLink < ActiveRecord::Base
  belongs_to :author, dependent: :destroy
  belongs_to :publication, dependent: :destroy

  validates_presence_of :author, :publication, :order
  validates_numericality_of :order

  def self.create_link author, publication, order
    link = AuthorPublicationLink.find_or_initialize_by(author_id: author.id, publication_id: publication.id)
    link.order = order
    link.save
    link
  end
end