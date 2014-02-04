class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :create, Comment
      can :update, Comment, :user_id => user.id
      can [:create, :policy, :sport, :culture, :business, :science], Post
      can :update, Post, :user_id => user.id
    end
  end
end
