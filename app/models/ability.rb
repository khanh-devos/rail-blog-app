class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    return unless user.admin?

    can :destroy, Post, user: user
    can :destroy, Comment, user: user

    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
