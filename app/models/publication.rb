# == Schema Information
#
# Table name: publications
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  venue      :string(255)
#  summary    :text
#  year       :integer
#  created_at :datetime
#  updated_at :datetime
#  link       :string(255)
#  abstract   :text
#  pdf_link   :string(255)
#

class Publication < ActiveRecord::Base
  has_many :author_publication_links
  has_many :authors, through: :author_publication_links
  has_many :summaries
  validates_presence_of :title, :year

  def ordered_authors
    self.author_publication_links.sort { |a,b| a.order <=> b.order }.map(&:author)
  end

  def self.create_publication title, venue, summary, year, link, abstract=nil, pdf_link=nil, *author_names
    p = Publication.find_or_initialize_by(title: title)
    p.venue = venue
    p.summary = summary
    p.year = year
    p.link = link
    p.abstract = abstract
    p.pdf_link = pdf_link
    p.save
    authors = Author.get_for_names(*author_names).index_by(&:name)
    sorted_authors = author_names.map { |author_name| authors[author_name] }
    sorted_authors.each.each_with_index do |author, i|
      AuthorPublicationLink.create_link(author, p, i)
    end
    return p
  end
end