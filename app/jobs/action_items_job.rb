class ActionItemsJob < ApplicationJob
    queue_as :default
  
    def perform
        children = Child.joins(:user_children).where(system_status: :active)
        children.each do |child|
            days_in_system = ((Time.now - child.created_at) / 86400).to_i
            puts("#{child.first_name} #{child.last_name} is #{days_in_system} days in system")
            if ( days_in_system != 0 && days_in_system % 30 == 0 )
                puts("YES")
                child.user_children.each do |user| 
                    User.find(user.user_id).organizations.each do |org|
                        ActionItem.create!(
                            organization_id: org.id,
                            user_id: child.user_children[0].user_id,
                            child_id: child.id, 
                            description: "Child #{child.first_name} #{child.last_name} is already #{days_in_system} days in system",
                            title: "System Notification",
                        )
                    end
                end
            end
        end
    end
  end
  