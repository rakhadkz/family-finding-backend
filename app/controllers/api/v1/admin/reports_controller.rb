class Api::V1::Admin::ReportsController < ApplicationController
    before_action :authenticate_request!
    before_action :require_admin
    include Filterable

    # Total Children in the system by month (last 12 months)
    # Total Placements by month (last 12 months)
    # Total “Linked” Connections found by month (last 12 months) (only Linked connections)

    def children
        chart_data = []
        12.times do |i|
            chart_data << children_scope.where('children.created_at BETWEEN ? AND ?', i.month.ago.beginning_of_month, i.month.ago.end_of_month ).count
        end
        render json: { message: "success", children: chart_data }, status: :ok
    end

#     <= 30 days = green
#     31 to 60 days = yellow
#     61 to 90 days = orange
#     91 to 120 days = red
#     120+ = black

    def gauge
        gauge1 = children_scope.where('children.created_at > ?', 30.days.ago).count 
        gauge2 = children_scope.where('children.created_at > ?', 60.days.ago).count - gauge1 
        gauge3 = children_scope.where('children.created_at > ?', 90.days.ago).count - gauge2 - gauge1  
        gauge4 = children_scope.where('children.created_at > ?', 120.days.ago).count - gauge3 - gauge2 - gauge1
        gauge5 = children_scope.where('children.created_at < ?', 120.days.ago).count
        chart_data = [gauge1,gauge2,gauge3,gauge4,gauge5]
        render json: { message: "success", chart_data: chart_data }, status: :ok
    end

    def placements
        chart_data = []
        12.times do |i|
            chart_data << ChildContact.where('created_at BETWEEN ? AND ?', i.month.ago.beginning_of_month, i.month.ago.end_of_month ).where(:status => 'Placed').count
        end
        render json: { message: "success", placements: chart_data }, status: :ok
    end

    def linked_connections
        chart_data = []
        12.times do |i|
            chart_data << ChildContact.where('created_at BETWEEN ? AND ?', i.month.ago.beginning_of_month, i.month.ago.end_of_month ).where(:is_confirmed => true).count
        end
        render json: { message: "success", linkedConnections: chart_data }, status: :ok
    end
  
    private
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
        if params[:goal]
            children = children.where(:permanency_goal => params[:goal])
        end
        return children
    end
  end
    