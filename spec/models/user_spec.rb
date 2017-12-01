require 'rails_helper'

RSpec.describe User, type: :model do

    # Create a user
    let(:user) { create(:user) }

    describe "attributes" do
        it "has email attribute" do
            expect(user).to have_attributes(email: user.email, password: user.password)
        end
    end
end
