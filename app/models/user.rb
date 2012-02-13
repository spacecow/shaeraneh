class User < ActiveRecord::Base
  before_create :set_role
  before_save :encrypt_password
  
  attr_accessor :password

  validates_presence_of :password, :on=>:create
  validates_confirmation_of :password
  validates :email, presence:true, uniqueness:true

  ADMIN     = 'admin'
  GOD       = 'god'
  MEMBER    = 'member'
  MINIADMIN = 'miniadmin'
  VIP       = 'vip'
  ROLES     = [GOD,ADMIN,MINIADMIN,VIP,MEMBER]

  class << self
    def authenticate(login,password)
      user = find_by_email(login)
      if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
        user
      end
    end

    def role(s) 2**ROLES.index(s.to_s) end
  end

  private

    def encrypt_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
      end
    end

    def set_role
      self.roles_mask = User.role(:member) unless roles_mask
    end
end
