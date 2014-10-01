# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  worker_id     :string(255)
#  hit_id        :string(255)
#  assignment_id :string(255)
#  summary_id    :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
