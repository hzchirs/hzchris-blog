class PostPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user
        if user.admin?
          scope.all
        else
          user.posts
        end
      else
        scope.published
      end
    end
  end

  def show?
    if user
      user.admin? or user.author?(record)
    else
      record.publish?
    end
  end

  def update?
    user.try(:admin?) or user.try(:author?, record)
  end
end
