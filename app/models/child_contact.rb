class ChildContact < ApplicationRecord
  belongs_to :child
  belongs_to :contact

  belongs_to :parent, class_name: "ChildContact", foreign_key: :parent_id
  has_many :children, class_name: "ChildContact", foreign_key: :parent_id

  has_many :child_contact_attachments
  has_many :attachments, through: :child_contact_attachments

  has_many :child_contact_comments
  has_many :comments, through: :child_contact_comments

  has_many :templates_sents
  has_many :communication_templates, through: :templates_sents

  has_many :family_search_connections

  has_many :family_searches

  has_one :link_score

  after_create :create_link_score_method

  after_find :calculate_link_score

  def calculate_link_score
    create_link_score_method
    overall = LinkScoreCalculator.new(self).calculate
    self.update!(link_score_overall: overall)
  end

  def create_link_score_method
    create_link_score! unless link_score
  end

  def linked_connection
    connection = LinkedConnection.where(connection_2_id: id).first&.connection_1
    return nil unless connection
    {
      child_contact_id: connection.id,
      contact_id: connection.contact_id,
      child_id: connection.child_id,
      first_name: connection.contact.first_name,
      last_name: connection.contact.last_name
    }
  end
  
  enum status: { 
    placed: "Placed", 
    support_resource_only: "Support Resource Only",
    disqualified: "Disqualified", 
    interested_in_placement: "Interested in Placement",
  }

end
