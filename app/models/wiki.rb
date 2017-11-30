class Wiki < ApplicationRecord
    belongs_to :user
    after_initialize :init

    private
    def init
        self.private = false if self.private.nil?
    end
end
