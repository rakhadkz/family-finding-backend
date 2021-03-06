class Child < ApplicationRecord
  has_many :attachments
  has_many :findings
  has_many :search_vectors, through: :findings

  has_many :child_contacts
  has_many :contacts, through: :child_contacts

  has_many :child_tree_contacts
  has_many :contacts, through: :child_tree_contacts

  has_many :child_attachments
  has_many :attachments, through: :child_attachments

  has_many :siblingships
  has_many :siblings, through: :siblingships

  has_many :inverse_siblingships, class_name: 'Siblingship', foreign_key: 'sibling_id'
  has_many :inverse_siblings, through: :inverse_siblingships, source: :child

  has_many :action_items

  has_many :user_children, dependent: :destroy
  has_many :users, -> { where.not(user_children: {date_approved: nil})}, through: :user_children

  has_many :comments

  enum continuous_search: { ON: "on", OFF: "off"}

  enum permanency_goal: {
    "Return to Parent(s) (Reunification)": "return_to_parent",
    "Adoption": "adoption",
    "Permanent Legal Custody (PLC)": "permanent_legal_custody",
    "Permanent Placement with a Fit and Willing Relative": "permanent_placement",
    "Another Planned Permanent Living Arrangement (APPLA)": "appla"
  }

  include PgSearch::Model

  pg_search_scope :search,
                  against: [
                    :first_name, :last_name
                  ],
                  using: {
                    tsearch: {prefix: true}
                  }

  def all_siblings
    self.siblings + self.inverse_siblings
  end
end
