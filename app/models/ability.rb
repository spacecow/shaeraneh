class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, User
    if user
      can :show, User
    end
  end
end
