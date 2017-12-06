class WikiPolicy < ApplicationPolicy

	#You map controller actions to class methods

	class Scope
		attr_reader :user, :scope

   	def initialize(user, scope)
     	@user = user
     	@scope = scope
     end

		def resolve
			wikis = []
			if user && user.role == 'admin'
				wikis = scope.all # if the user is an admin, show them all the wikis
			elsif user && user.role == 'premium'
				all_wikis = scope.all
				all_wikis.each do |wiki|
					if wiki.public? || wiki.user == user || wiki.collaborators.where(user: user) != []
						wikis << wiki # if the user is premium, only show them public wikis, or private wikis they created, or private wikis they are a collaborator on
					end
				end
			else # this is the lowly standard user
				all_wikis = scope.all
				wikis = []
				all_wikis.each do |wiki|
					if wiki.public? || wiki.collaborators.where(user: user) != []
					wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
					end
				end
			end
			wikis # return the wikis array we've built up
		end
	end #end of class

end # end of policy
