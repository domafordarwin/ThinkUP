class PassagePolicy < ApplicationPolicy
  def index?
    developer? || admin?
  end

  def show?
    developer? || admin?
  end

  def create?
    developer? || admin?
  end

  def update?
    developer? || admin?
  end

  def destroy?
    admin?
  end
end
