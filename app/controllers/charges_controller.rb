

class ChargesController < ApplicationController

    before_action :authenticate_user!,  except: [:index, :show] #, :new, :create]

    def create
        # Creates a Stripe Customer object, for associating with the charge
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )
        # Where the real magic happens
        charge = Stripe::Charge.create(
            customer: customer.id, # Note -- this is NOT the user_id in your app
            amount: Amount.default,
            description: "BigMoney Membership - #{current_user.email}",
            currency: 'usd'
        )

        @user = User.find_by_email(current_user.email)
        @user.role = 'premium'
        @user.save

        flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
        redirect_to edit_user_registration_path # or wherever



        # Stripe will send back CardErrors, with friendly messages
        # when something goes wrong.
        # This `rescue block` catches and displays those errors.
        rescue Stripe::CardError => e
        flash[:alert] = e.message
        redirect_to new_charge_path
    end

    def new
        test1 = current_user

        @stripe_btn_data = {
            key:         "#{ Rails.configuration.stripe[:publishable_key] }",
            description: "BigMoney Membership - #{current_user.email}",
            amount:      Amount.default
        }
    end

    def destroy
        @user = User.find_by_email(current_user.email)
        @user.role = 'standard'

        if @user.save
            flash[:notice] = "Your account has been downgraded to standard."
            redirect_to edit_user_registration_path
        else
            flash.now[:alert] = "There was an error downgrading your account."
            redirect_to edit_user_registration_path
        end
    end
end
