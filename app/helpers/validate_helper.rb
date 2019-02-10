module ValidateHelper

  def validate_correct_params(rate)
    { tweet: { rate: rate, svm_rate_validate: true } }
  end

  def validate_positive_params
    { tweet: { rate: Tweet::POSITIVE, svm_rate_validate: false } }
  end

  def validate_negative_params
    { tweet: { rate: Tweet::NEGATIVE, svm_rate_validate: false } }
  end

  def validate_neutral_params
    { tweet: { rate: Tweet::NEUTRAL, svm_rate_validate: false } }
  end
end
