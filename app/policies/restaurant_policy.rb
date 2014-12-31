class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.client? || user.admin?
  end

  def update?
    user.client? || user.admin?
  end

  def destroy?
    user.client? || user.admin?
  end

  def index?
    true
  end

  def show?
    true
  end
end
