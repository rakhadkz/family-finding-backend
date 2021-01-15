class User < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :findings, dependent: :destroy
  has_many :action_items, dependent: :destroy

  has_many :user_organizations, -> { order(id: :asc) }, dependent: :destroy
  has_many :organizations, through: :user_organizations

  has_many :attachments, dependent: :destroy

  has_many :user_children, dependent: :destroy
  has_many :children, -> { where.not(user_children: {date_approved: nil})}, through: :user_children

  scope :filter_by_role, -> (role) do
    User.joins(:user_organizations).where(user_organizations: { role: role })
  end

  scope :filter_by_organization, -> (org_id) do
    User.joins(:user_organizations).where(user_organizations: { organization_id: org_id })
  end

  include PgSearch::Model

  pg_search_scope :search,
                  against: [
                    :first_name,
                    :last_name,
                    :role,
                    :email
                  ],
                  using: {
                    tsearch: {prefix: true}
                  }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :lockable

  enum role: {
    super_admin: 'super_admin',
    admin: 'admin',
    manager: 'manager',
    user: 'user'
  }

  def organization_users(role_scope = nil)
    users = role === 'super_admin' ? User.all : User.filter_by_organization(organization_id)
    role_scope ? users.filter_by_role(role_scope) : users
  end

  def organization_id
    if super.present?
      super
    else
      first_user_org.present? ? first_user_org.organization_id : nil
    end
  end

  def role
    if super.present?
      super
    else
      first_user_org.present? ? first_user_org.role : nil
    end
  end

  def action_items
    organization_id.present? && role != 'user' ?
        ActionItem.where(organization_id: organization_id).where.not(related_user_id: nil).or(ActionItem.where(user_id: id, organization_id: organization_id))
        : super.filter_by_org_id(organization_id)
  end

  def delete_role(user)
    if role === 'super_admin'
      user.user_organizations.destroy_all
    elsif %w[admin manager].include? role
      user.user_organizations.find_by(organization_id: organization_id).destroy!
    else
      nil
    end
  end

  def token
    JsonWebToken.encode(
      {
        user_id: id,
        email: email,
        first_name: first_name,
        last_name: last_name,
        role: role
      }, 6.weeks.from_now.to_i)
  end

  def first_user_org
    @user_org ||= user_organizations.present? ? user_organizations.first : nil
  end
end
