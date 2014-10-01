class TurkInterface
  def initialize
    RTurk.setup(
      Constants::AWS_ACCESS_KEY,
      Constants::AWS_SECRET_KEY,
      sandbox: Constants::TURK_SANDBOX_ENABLED
    )
  end

  def create_hit
    hit = RTurk::Hit.create(title: "Write a 50-140 character summary of a research abstract") do |hit|
      hit.max_assignments = 1
      hit.description = 'You will need to read a research abstract and then write a short summary about it.'
      hit.question(
        File.join(Constants::ROOT_URL, "summaries", "new?publication_id=1"),
        :frame_height => 1000
      )
      hit.reward = 0.01
      hit.qualifications.add :country, { eql: 'US' }
    end
  end
end