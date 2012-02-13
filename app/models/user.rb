class User < ActiveRecord::Base
  before_save :encrypt_password
  
  attr_accessor :password

  class << self
    def authenticate(login,password)
      user = find_by_email(login)
      p user.password_salt if user
      if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
        user
      end
    end
  end

  private

    def encrypt_password
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
    end
end
