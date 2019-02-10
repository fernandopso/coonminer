module Svm
  class TfIdf
    attr_accessor :token, :tweets_to_rate, :total_of_documents

    def initialize(token, tweets_to_rate)
      self.token = token
      self.tweets_to_rate = tweets_to_rate
      self.total_of_documents = token.tweets.count
    end

    def process
      ActiveRecord::Base.transaction do
        tweets_to_rate.each { |tweet| tweet.update(tf_idfs: tf_idfs(tweet)) }
        token.update(tf_idf_at: DateTime.current)
      end
    end

    private

    def tf_idfs(tweet)
      tweet.bag_of_words.uniq.map { |word| tf_idf(tweet, word) }
    end

    def tf_idf(tweet, word)
      term_frequency(tweet.bag_of_words, word) * inverse_document_frequency(word)
    end

    def term_frequency(bag_of_words, word)
      BigDecimal(bag_of_words.count(word)) / bag_of_words.count
    end

    def inverse_document_frequency(word)
      Math.log(total_of_documents/document_frequency(word))
    end

    def document_frequency(word)
      begin
        token.words.find_by_name(word).df
      rescue => e
        binding.pry
      end
    end
  end
end
