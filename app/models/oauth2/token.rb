module Oauth2::Token
  def self.included(klass)
    klass.class_eval do
      cattr_accessor :default_lifetime
      self.default_lifetime = 1.minute

      before_validation :setup, :on => :create
      validates :expires_at, :presence => true
      validates :token, :presence => true, :uniqueness => true

      scope :valid, lambda { where('expires_at > ?', Time.now.utc) }
    end
  end

  def expires_in
    (expires_at - Time.now.utc).to_i
  end

  def expired!
    self.expires_at = Time.now.utc
    self.save!
  end

  private

  def setup
    self.token = ::Oauth2::SecureToken.generate
    self.expires_at ||= self.default_lifetime.from_now
  end
end
