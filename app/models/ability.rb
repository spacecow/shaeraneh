class Ability
  include CanCan::Ability

  def initialize(user)
    can [:create,:signup_confirmation], User
    can [:index,:show], Poem
    can :index, Word
    can [:show,:index], Source
    if user
      can :show, User
      cannot [:create,:signup_confirmation], User
      if user.role? :admin
        can :manage, Poem
        can :manage, Locale
        can :manage, Translation
        can :manage, Verse
        can :manage, Word
        can :manage, Source
      end
      if user.role? :god
        can :manage, :all
        cannot :create, User
      end
    end
  end
end
