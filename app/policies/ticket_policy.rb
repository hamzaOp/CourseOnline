class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.try(:admin?) || record.course.has_member?(user)
  end

  def create?
    user.try(:admin?) || record.course.has_manager?(user) ||
        record.course.has_editor?(user)
  end

  def update?
    user.try(:admin?) || record.course.has_manager?(user) ||
        (record.course.has_editor?(user) && record.author == user)
  end

  def destroy?
    user.try(:admin?) || record.course.has_manager?(user)
  end
end
