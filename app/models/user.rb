class User < ActiveRecord::Base
  ADMIN = ENV['COONMINER_ADMIN_ROLE'] || 'admin'

  devise :database_authenticatable, :rememberable, :trackable

  validates :email, presence: true, allow_blank: false

  belongs_to :company

  scope :admins, -> { where(role: ADMIN) }
  scope :current_sign_in_at_desc, -> { order('current_sign_in_at desc') }

  after_create :company_builder

  def create_token?
    tokens.count < Company::MAX_TOKENS
  end

  def admin?
    role == ADMIN
  end

  def free?
    role.nil?
  end

  def owner?(token_id)
    tokens.where(uuid: token_id).any?
  end

  def tokens
    company.tokens
  end

  def username_or_email
    username || email
  end

  private

  def company_builder
    c = self.create_company
    update(company_id: c.id)
  end

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(twitter_id: auth_hash.uid).first_or_create
    user_email = user.email.present? ? user.email : "#{auth_hash.info.nickname}@twitter.com"
    user.update(
      email: user_email,
      username: auth_hash.info.nickname,
      avatar: auth_hash.info.image,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
    user
  end
end
