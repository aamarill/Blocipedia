class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable,
            :registerable,
            :recoverable,
            :rememberable,
            :trackable,
            :validatable,
            :confirmable

    has_many :wikis, dependent: :destroy
    has_many :collaborators
    # has_many :wikis, through: :collaborators

    after_initialize :init



    private
    def init
        # The default user type will be standard, no matter what the user inputs
        if self.role == nil
            self.role = "standard"
        end
    end
end
