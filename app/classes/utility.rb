class Utility
  def self.gen_random_word(n=8)
    letters = [('a'..'z').to_a, ('A'..'Z').to_a].flatten
    n.times.map { |i| letters.sample }.join("")
  end

  def self.reset o_auth_token=nil
    Utility.scrape
    Utility.author_fb_images o_auth_token if o_auth_token
  end

  def self.scrape
    urls = [
      "https://www.facebook.com/publications/?area=461740707230724", # data science
      "https://www.facebook.com/publications/?area=459975547407240", # hci
      "https://www.facebook.com/publications/?area=492227434182051" # social computing
    ]
    urls.each do |url|
      doc = Nokogiri::HTML(open(url))
      year_pubs = doc.css("._4-u2.mtm.pal")
      year_pubs.each do |item|
        year = item.css("._4-u3._52jw").text[0..3]
        pubs = item.css("._4-u3.pts.pbl")
        pubs.each do |pub|
          title = pub.css("h2").text
          purl = pub.css("h2 a").first['href']
          venue = pub.css("._52ye._52ie").text
          author_names = pub.css("._52ye").first.text.split(",").map { |name| name.strip }
          p author_names
          author_links = Hash[*pub.css("._52ye a").map { |i| [i.text, i['href']]}.flatten]
          p author_links
          author_names.each do |name|
            Author.create_author name, nil, author_links[name]
          end

          pub_doc = Nokogiri::HTML(open(purl))
          abstract = pub_doc.css("._52ii._52ie").text
          links = pub_doc.css("a._42ft")
          pdf_link = links.select { |link| link.text == "Download File" }.first['href']
          # p "#{title}, #{venue}, #{year}, #{purl}, #{author_names.join(",")}"
          Publication.create_publication(title, venue, "", year, purl, abstract, pdf_link, *author_names)
        end
      end
    end
  end

  # Get access token from: https://developers.facebook.com/tools/explorer?method=GET&path=me%3Ffields%3Did%2Cname&version=v2.1
  def self.author_fb_images o_auth_token
    graph = Koala::Facebook::API.new o_auth_token
    to_query = Author.all.select { |a| a.fb_profile.present? && a.image_url.nil? }
    to_query.each do |tq|
      tq.remote_image_url = graph.get_picture(tq.fb_profile.split("/").last)
      tq.save
    end
  end

  # def self.create_authors
  #   Author.create_author "Sauvik Das", "https://facebook.com/sauvikdas", ""
  #   Author.create_author "Moira Burke", "https://facebook.com/mburke", ""
  #   Author.create_author "Adam Kramer", "", ""
  #   Author.create_author "Robert Kraut", "", ""
  #   Author.create_author "Eric Sun", "", ""
  #   Author.create_author "Itamar Rosenn", "", ""
  #   Author.create_author "Cameron Marlow", "", ""
  #   Author.create_author "Thomas Lento", "", ""
  #   Author.create_author "Jonathan Chang", "", ""
  #   Author.create_author "Lars Backstrom", "", ""
  #   Author.create_author "Eytan Bakshy", "", ""
  #   Author.create_author "Jon Kleinberg", "", ""
  #   Author.create_author "Johan Ugander", "", ""
  #   Author.create_author "Rong Yan", "", ""
  #   Author.create_author "Paolo Boldi", "", ""
  #   Author.create_author "Sebastiano Vigna", "", ""
  #   Author.create_author "Robert Bond", "", ""
  #   Author.create_author "Chris Fariss", "", ""
  #   Author.create_author "Jason Jones", "", ""
  #   Author.create_author "Cameron Marlow", "", ""
  #   Author.create_author "Jaime Settle", "", ""
  #   Author.create_author "James Fowler", "", ""
  #   Author.create_author "Shaomei Wu", "", ""
  #   Author.create_author "Atish Das Sarma", "", ""
  #   Author.create_author "Alex Fabrikant", "", ""
  #   Author.create_author "Andrew Tomkins", "", ""
  #   Author.create_author "Silvio Lattanzi", "", ""
  # end

  # def self.create_publications
  #   Publication.create_publication(
  #     "Self-Censorship on Facebook",
  #     "ICWSM",
  #     "71% of people self-censor Facebook posts and/or comments at the last minute.",
  #     "2013",
  #     "https://www.facebook.com/publications/493601774027388/",
  #     "Sauvik Das",
  #     "Adam Kramer"
  #   )

  #   Publication.create_publication(
  #     "Self-Censorship on Facebook",
  #     "ICWSM",
  #     "71% of people self-censor Facebook posts and/or comments at the last minute.",
  #     "2013",
  #     "https://www.facebook.com/publications/493601774027388/",
  #     "Sauvik Das",
  #     "Adam Kramer"
  #   )
  # end
end