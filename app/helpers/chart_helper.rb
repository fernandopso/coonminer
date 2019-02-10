module ChartHelper
  def load_data_to_cloud_tags(token)
    {
      hashtags:  add_link_to_first_option_for(token.top_hashtags, :hashtags, token.uuid),
      locations: add_link_to_first_option_for(token.top_locations, :locations, token.uuid),
      languages: add_link_to_first_option_for(token.top_languages, :languages, token.uuid),
      mentions:  add_link_to_first_option_for(token.top_mentions, :mentions, token.uuid)
    }
  end

  private

  def add_link_to_first_option_for(options, type, id)
    first_option = options.shift
    options.unshift(first_option.merge(link: send("token_#{type}_path", id))) if first_option
    options.to_json
  end
end
