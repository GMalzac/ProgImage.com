class PicturePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    record.user == user
  end

  def jpeg?
    record.user == user
  end

  def gif?
    record.user == user
  end

  def png?
    record.user == user
  end

  def tiff?
    record.user == user
  end

  def download?
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
