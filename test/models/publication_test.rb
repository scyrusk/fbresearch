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

require 'test_helper'

class PublicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
