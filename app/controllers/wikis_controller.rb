class WikisController < ApplicationController
  before_action :authenticate_user!,  except: [:index, :show] #, :new, :create]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])

    unless policy(@wiki).collaborator?
      redirect_to action: :index
      flash[:alert] = "That wiki is private"
    end

  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body  = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user  = current_user

    if @wiki.save
      flash[:notice] = "Wiki was created succesfully"
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error creating the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    unless params[:wiki][:private].nil?
      @wiki.private = params[:wiki][:private]
    end

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated"
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again"
      render :edit
    end

  end

  def destroy
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end

  end

end
