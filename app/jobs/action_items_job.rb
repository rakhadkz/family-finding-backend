class ActionItemsJob < ApplicationJob
    queue_as :default
  
    def perform
        children = Child.joins(:user_children).where(system_status: :active)
        children.each do |child|
            days_in_system = (Time.now - child.created_at) / 86400).to_i
            if ( days_in_system != 0 && days_in_system % 30 == 0 )
                ActionItem.create!(
                    user_id: child.user_children[0].user_id,
                    child_id: child.id, 
                    description: 'some description',
                    title: "Some title",
                )
            end
        end
    end
  end
  