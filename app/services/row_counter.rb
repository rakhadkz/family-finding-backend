module RowCounter
  def self.count(string)
    doc = Nokogiri::HTML("<table style='border-collapse: inherit;'><tr><th>First Name</th><th>Last Name</th><th>Age</th><th>Race</th><th>Sex</th></tr><tr><td>SAM</td><td>JOHNSON</td><td>55</td><td>Black</td><td>Male</td></tr></table>", nil, 'UTF-8')
    tables = doc.css("table")
    tables.css("tr").count - 1
  end

  def self.count_from_task_id(child_contact, task_id)
    count(child_contact.family_searches.includes(:search_vector).find_by(search_vectors: { task_id: task_id }).description)
  end
end