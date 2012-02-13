class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, User
    can [:index,:show], Poem
    can :index, Word
    if user
      can :show, User
      cannot :create, User
      if user.role? :admin
        can :manage, Poem
        can :manage, Locale
        can :manage, Translation
        can :manage, Verse
        can :manage, Word
      end
      if user.role? :god
        can :manage, :all
        cannot :create, User
      end
    end
  end
end
