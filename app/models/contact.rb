class Contact < ApplicationRecord
  has_many :child_contacts
  has_many :communications
  has_many :children, through: :child_contacts, :source => :child

  belongs_to :address

  enum sex: {
    Male: "male",
    Female: "female"
  }

  enum race: {
    "American Indian or Alaska Native": "american_indian_or_alaska_native",
    "Asian": "asian",
    "Black or African American": "black_or_african_american",
    "Hispanic or Latino": "hispanic_or_latino",
    "Native Hawaiian or Other Pacific Islander": "native_hawaiian_or_other_pacific_islander",
    "White": "white"
  }

  after_find :create_address

  def create_address
    if address_id
      return
    end
    address = Address.create!
    self.update!(address_id: address.id)
  end

end
