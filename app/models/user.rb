class User < BaseModel
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

  include DeviseTokenAuth::Concerns::User

  validates_presence_of :email
  validates_uniqueness_of :email#, allow_blank: true, if: :email_changed?
  validates_format_of :email, with: /\A[^\s]+@[^\s]+\.[^\s]+\z/, on: :create#, allow_blank: true, if: :email_changed?

  validates_presence_of :password, on: :create
  validates_confirmation_of :password, on: :create
  validates_length_of :password, in: 6..64 , allow_blank: true

  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :articles
end