module Deliver
  class UserMailer < ActionMailer::Base
    layout 'email'

    default from: 'coonminer@gmail.com'

    def example
      mail to: "fernandopso3@gmail.com", subject: 'Ok'
    end

  end
end
