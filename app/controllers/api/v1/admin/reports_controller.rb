class Api::V1::Admin::ReportsController < ApplicationController
    before_action :authenticate_request!
    before_action :require_admin
    include Filterable

    # Total Children in the system by month (last 12 months)
    # Total Placements by month (last 12 months)
    # Total “Linked” Connections found by month (last 12 months) (only Linked connections)

    def children
        children = children_scope.where('children.created_at > ?', last_year)
        children_by_months = group(children)
        chart_data = prepare_data(children_by_months)
        render json: { message: "success", children: chart_data }, status: :ok
    end

#     <= 30 days = green
#     31 to 60 days = yellow
#     61 to 90 days = orange
#     91 to 120 days = red
#     120+ = black

    def gauge
        gauge1 = children_scope.where('created_at > ?', 30.days.ago).count
        gauge2 = children_scope.where('created_at > ?', 60.days.ago).count - gauge1
        gauge3 = children_scope.where('created_at > ?', 90.days.ago).count - gauge2
        gauge4 = children_scope.where('created_at > ?', 120.days.ago).count - gauge3
        gauge5 = children_scope.where('created_at < ?', 120.days.ago).count
        chart_data = [gauge1,gauge2,gauge3,gauge4,gauge5]
        render json: { message: "success", chart_data: chart_data }, status: :ok
    end

    def placements
        placed_contacts = ChildContact.where('created_at > ?', last_year).where(:status => 'Placed')
        placed_contacts_by_months = group(placed_contacts)
        chart_data = prepare_data(placed_contacts_by_months)
        render json: { message: "success", placements: chart_data }, status: :ok
    end

    def linked_connections
        linked_child_contacts = ChildContact.where('created_at > ?', last_year).where(:is_confirmed => true)
        linked_child_contacts_by_months = group(linked_child_contacts)
        chart_data = prepare_data(linked_child_contacts_by_months)
        render json: { message: "success", linkedConnections: chart_data }, status: :ok
    end
  
    private
    def last_year
        (DateTime.now - 11.month).beginning_of_month 
    end
    def group(records)
        records.group_by {|record| record.created_at.strftime("%B")}
    end
    def prepare_data(data)
        data.map {|month, items| [month, items.count]}
    end
    def group_gauge(records)
        records.group_by {|record| record.created_at.strftime("%B")}
    end
    def prepare_gauge(data)
        data.map {|month, items| [month, items.count]}
    end
    def children_scope
        if params[:filter].split(",").count === 1 && params[:filter].split(",")[0] == "active"
          children = Child.where(system_status: :active)
        elsif params[:filter].split(",").count === 1 && params[:filter].split(",")[0] == "assigned"
          children = Child.joins(:user_children)
        elsif params[:filter].split(",").count === 2
          children = Child.joins(:user_children).where(system_status: :active)
        else
          children = Child.all
        end
    end
  end
    