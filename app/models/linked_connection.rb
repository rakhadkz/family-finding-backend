class LinkedConnection < ApplicationRecord
  belongs_to :connection_1, class_name: 'ChildContact'
  belongs_to :connection_2, class_name: 'ChildContact'
end