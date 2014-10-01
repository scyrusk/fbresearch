class TurkInterface
  def initialize
    RTurk.setup(
      Constants::AWS_ACCESS_KEY,
      Constants::AWS_SECRET_KEY,
      sandbox: Constants::TURK_SANDBOX_ENABLED
    )
  end

  def create_hits
    pubs = Publication.all.map { |pub| [pub.id, Constants::REQUIRED_SUMMARIES - pub.summaries.length] }.select do |arr|
      arr[1] > 0
    end

    urls = pubs.map do |arr|
      create_hit arr[0], arr[1]
    end

    p urls
  end

  private
    def create_hit publication_id, assignments
      hit = RTurk::Hit.create(title: "Write a 50-140 character summary of a research abstract") do |hit|
        hit.max_assignments = assignments
        hit.description = 'You will need to read a research abstract and then write a short summary about it.'
        hit.lifetime = 60*60*24
        hit.question(
          File.join(Constants::ROOT_URL, "summaries", "new?publication_id=#{publication_id}"),
          :frame_height => 1000
        )
        hit.reward = Constants::SUMMARY_PAYMENTS
        hit.qualifications.add :country, { eql: 'US' }
        hit.qualifications.add :approval_rate, { :gt => 95 }
      end

      hit.url
    end
end