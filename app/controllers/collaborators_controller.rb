class CollaboratorsController < ApplicationController

  def create

    collaborator_email = params[:collaborator][:email]
		@wiki = Wiki.find(params[:wiki_id])
    collaborator = find_user_by_email(collaborator_email)

    if @wiki.collaborators.where(user: collaborator) != []
      redirect_to @wiki
      flash[:notice] = "User is already a collaborator"
      return
    end

    @collaborator = Collaborator.new
    @collaborator.wiki = @wiki
    @collaborator.user = collaborator

    if @collaborator.save
      redirect_to @wiki
      flash[:notice] = "Collaborator was added succesfully"
    else
      redirect_to @wiki
      flash[:notice] = "There was an error adding the collaborator"
    end

  end

  def edit

    collaborator_email = params[:collaborator][:email]
    @wiki = Wiki.find(params[:wiki_id])
    user_to_delete_id = find_collaborator(@wiki, collaborator_email)
    user_to_delete = User.find(user_to_delete_id)
    collaborator = Collaborator.where(user: user_to_delete)
    collaborator = collaborator[0]

    if collaborator.destroy
      redirect_to @wiki
      flash[:notice] = "collaborator removed"
    else
      redirect_to @wiki
      flash[:notice] = "collaborator removing error"
    end

  end

  private

  def find_user_by_email(email)
    user = User.where(email: email)
    user = User.find(user[0].id)
  end

  def find_collaborator(wiki, collaborator_email)
    output = nil

    wiki.collaborators.each do |collaborator|

      if collaborator.user.email == collaborator_email
        output = collaborator.user.id
        break
      end

    end

    return output

  end

end
