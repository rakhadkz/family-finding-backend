class LinkScoreCalculator
  def initialize(connection)
    @connection = connection
    @overall = 40
    @categories = {
      criminal_records: 0,
      demographics: 0,
      financial: 0,
      housing: 0,
      transportation: 0
    }
  end

  def calculate
    begin
      megans_low
      proximity
      criminal_records

      @categories.each { |key, value| @overall += value}
    rescue ArgumentError => e
      @overall = 0
      if e.instance_of? ZeroCriminalHistory
        @categories[:criminal_records] = 0
      elsif e.instance_of? ZeroDemographics
        @categories[:demographics] = 0
      elsif e.instance_of? ZeroFinancial
        @categories[:financial] = 0
      elsif e.instance_of? ZeroHousing
        @categories[:housing] = 0
      elsif e.instance_of? ZeroTransportation
        @categories[:transportation] = 0
      end
    ensure
      @connection.link_score.update(@categories)
      @overall
    end
  end

  def proximity
    proximity = DistanceMatrix.calculate(@connection.child.address, @connection.contact.address) / 1.609
    if proximity <= 10
      @categories[:housing] += 20
    elsif proximity > 10 && proximity <= 30
      @categories[:housing] += 10
    elsif proximity > 30 && proximity <= 60
      @categories[:housing] += 5
    else
      @categories[:housing] += 0
    end
  end

  def criminal_records
    criminal_records = RowCounter.count_from_task_id(@connection, "qfpI8LT6l00ylR9dT")
    if criminal_records >= 1 && criminal_records < 3
      @categories[:criminal_records] -= 20
    elsif criminal_records >= 3 && criminal_records < 5
      @categories[:criminal_records] -= 40
    elsif criminal_records >= 5 && criminal_records < 10
      @categories[:criminal_records] -= 60
    elsif criminal_records >= 10
      raise ZeroCriminalHistory.new "More than 10 Criminal Records found"
    end
  end

  def megans_low
    megans_low = RowCounter.count_from_task_id(self, "AAn4h8mfBNaKk33Rb")
    if megans_low >= 1
      @connection.update!(is_disqualified: true, disqualify_reason: "Pa Megan's Low Registration found") if self.is_disqualified != true
      raise ZeroCriminalHistory.new "Pa Megan's Low Registration found"
    end
  end

end
