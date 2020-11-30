class Siblingship < ApplicationRecord
  belongs_to :child
  belongs_to :sibling, class_name: 'Child'

  validate :siblings

  private
  def siblings
    combinations = ["child_id = #{child_id} AND sibling_id = #{sibling_id}",
                    "child_id = #{sibling_id} AND sibling_id = #{child_id}"]
    if Siblingship.where(combinations.join(' OR ')).exists?
      self.errors.add('Siblingship', 'already exists!')
    end
  end
end
