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

require 'test_helper'

class SummaryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
