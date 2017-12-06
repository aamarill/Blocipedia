class Wiki < ApplicationRecord
    belongs_to :user
    has_many :collaborators
    after_initialize :init

    def public?
      !self.private
    end

    private
    def init
        self.private = false if self.private.nil?
    end
end
