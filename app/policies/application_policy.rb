class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    if record.private == true
        user == record.user
    else
        user.present?
    end
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (user == record.user)
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

    def premium?
        user.role == 'premium'
    end

    def admin?
        user.role == 'admin'
    end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
