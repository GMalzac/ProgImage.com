class PicturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    record.user == user
  end

  # def update?
  #   record.user == user
  # end

  def create?
    !user.nil?
  end

  def destroy?
    record.user == user
  end
end
