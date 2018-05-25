class WikiPolicy < ApplicationPolicy
	class Scope
		attr_reader :user, :scope

   	def initialize(user, scope)
     	@user = user
     	@scope = scope
     end

		def resolve
			wikis = []

			if user && user.role == 'admin'
				wikis = scope.all
			elsif user && user.role == 'premium'
				all_wikis = scope.all
				all_wikis.each do |wiki|
					if wiki.public? || wiki.user == user || wiki.collaborators.where(user: user) != []
						wikis << wiki
					end
				end
			else
				all_wikis = scope.all
				wikis = []
				all_wikis.each do |wiki|
					if wiki.public? || wiki.collaborators.where(user: user) != []
						wikis << wiki
					end
				end
			end

			wikis

		end

	end

end
