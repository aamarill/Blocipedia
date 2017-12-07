class ChargesController < ApplicationController

  before_action :authenticate_user!,  except: [:index, :show]

  def create
    customer = Stripe::Customer.create(email: current_user.email, card: params[:stripeToken])
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    @user = User.find_by_email(current_user.email)
    @user.role = 'premium'
    @user.save

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to edit_user_registration_path

    rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  def destroy
    @user = User.find_by_email(current_user.email)
    @user.role = 'standard'

    @user.wikis.each do |wiki|
      wiki.private = false
      wiki.save
    end

    if @user.save
      flash[:notice] = "Your account has been downgraded to standard."
      redirect_to edit_user_registration_path
    else
      flash.now[:alert] = "There was an error downgrading your account."
      redirect_to edit_user_registration_path
    end

  end

end
