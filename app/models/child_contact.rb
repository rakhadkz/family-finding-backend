class ChildContact < ApplicationRecord
  belongs_to :child
  belongs_to :contact

  validates :family_fit_score, :inclusion => { :in => 0..5 }

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

  belongs_to :link_score

  def link_score_number
    LinkScoreCalculator.new(self).calculate
  end

end
