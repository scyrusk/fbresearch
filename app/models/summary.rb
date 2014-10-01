# == Schema Information
#
# Table name: summaries
#
#  id             :integer          not null, primary key
#  publication_id :integer
#  content        :text
#  worker_id      :string(255)
#  hit_id         :string(255)
#  assignment_id  :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Summary < ActiveRecord::Base
  belongs_to :publication, dependent: :destroy
  has_many :votes

  validates_length_of :content, minimum: 50, maximum: 140, message: "Your summary must be between 50 and 140 characters"

  def num_votes
    self.votes.length
  end
end
