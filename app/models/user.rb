class User < ApplicationRecord
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable,
    :confirmable

  has_many :collaborators, dependent: :destroy
  has_many :wikis, through: :collaborators

  after_initialize :init

  private

  def init

    if self.role == nil
      self.role = "standard"
    end

  end

end
