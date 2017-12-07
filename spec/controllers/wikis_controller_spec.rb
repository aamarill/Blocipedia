require 'rails_helper'
include RandomData
# include SessionsHelper

RSpec.describe WikisController, type: :controller do

  let(:user) { create(:user)}
  let(:wiki) { create(:wiki, user: user)}

  context "public/guest (un-signed in) user" do
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index, params: {id: wiki.id }
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: {id: wiki.id } #it's rspec convention to use "id" as the parameter used to find the route
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: {id: wiki.id }
        expect(response).to render_template :show
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context "signed-in user" do
    before do
      sign_in user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
      it "renders the #index view" do
        get :index, params: {id: wiki.id }
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, params: {id: wiki.id } #it's rspec convention to use "id" as the parameter used to find the route
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: {id: wiki.id }
        expect(response).to render_template :show
      end

      it "assigns my_post to @post" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new, params: { id: wiki.id }
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST #create" do
      it "increases the number of Wiki by 1" do
        expect{ post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to Wiki" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, params: { wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
        expect(response).to redirect_to [Wiki.last]
      end
    end

  end

end
