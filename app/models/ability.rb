class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Post

    return unless user.present?

    can :manage, Post, author_id: user.id
    can :manage, Comment, user_id: user.id

    return unless user.admin?

    can :manage, :all

    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
