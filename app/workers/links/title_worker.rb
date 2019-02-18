# frozen_string_literal: true

require 'open-uri'
require 'open_uri_redirections'

module Links
  class TitleWorker
    include Sidekiq::Worker

    sidekiq_options retry: 0

    def perform(url, link_id)
      Link.find(link_id).update title: title_for(request_page(url))
    end

    private

    def request_page(url)
      open(url, allow_redirections: :all).read
    end

    def title_for(html)
      html[7 + begin_title(html)..final_title(html) - 1]
    end

    def begin_title(body)
      body =~ /<title>/
    end

    def final_title(body)
      body =~ /<\/title>/
    end
  end
end
