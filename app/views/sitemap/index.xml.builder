xml.instruct! :xml, :version=> "1.0"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  for token in @tokens do
    xml.url do
      xml.loc token_tweets_url(token.uuid)
      xml.lastmod token.updated_at.to_date
      xml.changefreq "weekly"
      xml.priority "0.9"
    end
  end
end
