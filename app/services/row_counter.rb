module RowCounter
  def self.count(string)
    doc = Nokogiri::HTML(string, nil, 'UTF-8')
    tables = doc.css("table")
    tables.css("tr").count - 1
  end

  def self.count_from_task_id(child_contact, task_id, category)
    family_search = child_contact.family_searches.includes(:search_vector).find_by(search_vectors: { task_id: task_id })
    raise NilInfoError.new(category) unless family_search
    count(family_search.description)
  end
end