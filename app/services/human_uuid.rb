class HumanUuid

  attr_accessor :token, :iterator

  def initialize(token, iterator = "")
    self.token = token + iterator
    self.iterator = iterator
  end

  def call
    another_token = Token.find_by_uuid(token.parameterize)
    if another_token.nil?
      if token.parameterize.blank?
        SecureRandom.hex(4)
      else
        token.parameterize
      end
    else
      HumanUuid.new(token.parameterize, "-" + SecureRandom.hex(2)).call
    end
  end
end
