class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.superadmin? || user.site_admin?
      can :manage, :all
    else
      can :read, Library
      can :read, Location
      can :read, Calendar
    end
  end
end
