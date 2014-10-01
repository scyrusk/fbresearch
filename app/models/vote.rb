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

class Vote < ActiveRecord::Base
  belongs_to :summary

  validate :unique_for_summary

  def unique_for_summary
    scope = Vote.where("summary_id = ?", summary.id)
    check = scope.map(&:worker_id).include?(worker_id)
    errors.add(:worker_id, "Looks like you already voted.")
  end
end
