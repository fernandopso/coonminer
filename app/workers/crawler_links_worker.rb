require 'open-uri'
require 'open_uri_redirections'

class CrawlerLinksWorker
  include Sidekiq::Worker

  LOG_NAME = 'CrawlerLinksWorker >'

  CHAR_CODE = {
    "&#233;" => "é",
    "&#231;" => "ç",
    "&#227;" => "õ",
    "&quot;" => "",
    "&laquo;" => "",
    "&nbsp;" => " ",
    "&rsquo;" => "",
    "&raquo;" => "",
    "&#8211;" => "-",
    "&#39;" => "",
    "&eacute;" => "é",
    "&Eacute;" => "É",
    "&egrave;" => "è",
    "&#039;" => ""
  }

  def perform
    logger.info "#{LOG_NAME} start"

    token = Token.collect_at_desc.sample

    logger.info "#{LOG_NAME} take token #{token.word}"

    links = token.links.where(title: nil).order(df: :desc).take(10)

    links.each do |link|
      begin
        html = open(link.href, allow_redirections: :all).read

        begin_title = html =~ /<title>/
        final_title = html =~ /<\/title>/

        title = replace_char(html[7 + begin_title..final_title - 1].encode("UTF-8"))

        link.update title: title

        logger.info "#{LOG_NAME} #{link.href} #{link.title}"
      rescue => exception
        logger.info "#{LOG_NAME} Error: #{exception}"
      end
    end

    logger.info "#{LOG_NAME} token to token #{token.word}"
  end

  private

  def replace_char(title)
    CHAR_CODE.keys.each { |key| title.gsub!(key, CHAR_CODE[key]) }

    title
  end
end
