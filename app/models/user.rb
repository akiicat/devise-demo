class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable,
         :authentication_keys => [:login], :omniauth_providers => [:facebook]

  has_many :books

  attr_accessor :login

  validates :name,
            :presence => true,
            :uniqueness => {
              :case_sensitive => false
            },
            :format => {
              with: /\A[a-zA-Z0-9_\-]+\z/
            }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:name) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  protected

  def confirmation_required?
    false
  end
end
