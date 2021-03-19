Rake::Task.clear
require 'digest/sha1'
require 'nokogiri'
require 'net/https'

class UjsportalPacourtsUsJob < ApplicationJob
  queue_as :default
  SEARCH_VECTOR_ID = 5
  def perform(options)
    if options[:family_search_id].present?
      family_search = FamilySearch.find options[:family_search_id]
      raise ArgumentError.new "Connection id cannot be nil" if family_search.child_contact_id.nil?
      raise ArgumentError.new "Not Ujs search vector!" if family_search.search_vector_id != SEARCH_VECTOR_ID
      send_request family_search
    else
      scope.each { |family_search| send_request family_search }
    end
  end

  private
  def scope
    FamilySearch.filter_by_search_vector_for_job(SEARCH_VECTOR_ID)
  end

  def send_request(family_search)
    return if family_search.child_contact.nil?
    first_name = family_search.child_contact.contact.first_name
    last_name = family_search.child_contact.contact.last_name
    uri = URI('https://ujsportal.pacourts.us/CaseSearch')
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req['Content-Type'] = 'application/x-www-form-urlencoded'
    req['Cookie'] = 'ASP.NET_SessionId=crfqutfefikkhg30cf14br2z; .AspNetCore.Antiforgery.SBFfOFqeTDE=CfDJ8LeJeCJb_ztImosVsKnfuYf38G-vgTwpOQKGtySsnzrxRJdGxoIJgRIfczs0jXAyoy6h-zFRJo90D6Me26DMEEM8bkBAbXXF30JBbYbDQQ47rv37nMVu3MZWvtUR5-19iP7BA0AIRbPlgekPUa1T90w; f5avraaaaaaaaaaaaaaaa_session_=EFDIMDLKBNEMAEOBJEGFMEEONHPGJGMNNDHBHJNALKEHLFBAALBIENMDKECBNOJGAJEDPEENMDIBGECAEOOAAFBHOHFMHHLLCCDMBGCKNOOMAOCBNKNHDANAFDLDJBKF'
    req.body = URI.encode_www_form([
                                     [ "SearchBy", "ParticipantName" ],
                                     [ "FiledStartDate", "2020-02-01" ],
                                     [ "FiledEndDate", "2021-03-18" ],
                                     [ "ParticipantLastName", last_name ],
                                     [ "ParticipantFirstName", first_name ],
                                     [ "__RequestVerificationToken", "CfDJ8LeJeCJb_ztImosVsKnfuYcCr6K5Z-IMIpAp2gUA4SAhAyWMww62tYGWMLR-Pu-yudz2Zv22WKHSkYJfgXZhveOFGdO_63mKjCLiG7f44-J5K1lfek816o1C_6zEBL_RB6OKo9OREVQDMxVw069GCF0" ],
                                   ])
    doc = Nokogiri::HTML(https.request(req).body)
    table = doc.search('#caseSearchResultGrid')
    if Digest::SHA1.hexdigest(table.to_s) != family_search.hashed_description
      family_search.update date_completed: nil
      result = "<table><tr><th>Docket Number</th><th>Court Type</th><th>Case Caption</th><th>Case Status</th><th>Filing Date</th><th>Primary Participant(s)</th><th>Date Of Birth(s)</th><th>County</th><th>Court Office</th><th>OTN</th><th>LOTN</th><th>Police Incident/ Complaint</th></tr>"
      rows = table.css("tr")
      rows.map do |row|
        result += "<tr>"
        row.css('td').each_with_index { |data, index| result += "<td>#{data.text}</td>" if index > 1 && index < 14 }
        result += "</tr>"
      end
      result += "</table>"
      family_search.description = result
      family_search.hashed_description = Digest::SHA1.hexdigest(result)
      family_search.date_completed = Time.now
      family_search.is_link_alert = true if family_search.is_link_alert === false || family_search.is_link_alert.nil?
      family_search.save
    end
  end
end
