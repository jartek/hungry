class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user && (user.client? || user.admin?)
  end

  def update?
    user && (user.client? || user.admin?)
  end

  def destroy?
    user && (user.client? || user.admin?)
  end

  def index?
    true
  end

  def show?
    true
  end
end
