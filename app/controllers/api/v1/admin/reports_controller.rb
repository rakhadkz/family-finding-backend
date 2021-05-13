class Api::V1::Admin::ReportsController < ApplicationController
    before_action :authenticate_request!
    before_action :require_admin
    
    # Total Children in the system by month (last 12 months)
    # Total Placements by month (last 12 months)
    # Total “Linked” Connections found by month (last 12 months) (only Linked connections)

    def children
        children = Child.where('created_at > ?', last_year)
        children_by_months = group(children)
        chart_data = prepare_data(children_by_months)
        render json: { message: "success", children: chart_data }, status: :ok
    end

    def placements
        placed_contacts = ChildContact.where('created_at > ?', last_year).where(:status => 'Placed')
        placed_contacts_by_months = group(placed_contacts)
        chart_data = prepare_data(placed_contacts_by_months)
        render json: { message: "success", children: chart_data }, status: :ok
    end

    def linked_connections
        linked_child_contacts = ChildContact.where('created_at > ?', last_year).where(:is_confirmed => true)
        linked_child_contacts_by_months = group(linked_child_contacts)
        chart_data = prepare_data(linked_child_contacts_by_months)
        render json: { message: "success", children: chart_data }, status: :ok
    end
  
    private
    def last_year
        (DateTime.now - 11.month).beginning_of_month 
    end
    def group(records)
        records.group_by {|record| record.created_at.strftime("%B")}
    end
    def prepare_data(data)
        data.map {|month, items| {month => items.count}}
    end
  end
    