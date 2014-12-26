class User < ActiveRecord::Base
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable

  include DeviseTokenAuth::Concerns::User

  enum role: [:user, :client, :admin]

  after_initialize :set_default_role, if: :new_record?

  validates :role, presence: true, inclusion: { in: roles.keys }

  has_many :reviews

  private

  def set_default_role
    self.role ||= :user
  end
end
