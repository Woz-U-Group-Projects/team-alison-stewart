class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    set_permissions
  end

  private

  def set_permissions
    set_guest_permissions

    set_admin_permissions   if @user&.is?(:admin)
    set_teacher_permissions if @user&.is?(:teacher)
  end

  def set_guest_permissions
    can :read, :all
  end

  def set_admin_permissions
    can :manage, :all
  end

  def set_teacher_permissions
    can :create, :id_card_request
    can :create, :node
  end
end
