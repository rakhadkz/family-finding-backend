class LinkScoreCalculator

  CATEGORIES = {
    criminal_history: 2,
    demographics: 1  ,
    financial: 0,
    housing: 1,
    transportation: 0
  }

  def initialize(connection)
    @connection = connection
    @overall = 40
    @categories = {
      criminal_history: nil,
      demographics: nil,
      financial: nil,
      housing: nil,
      transportation: nil
    }
    @nil_categories = CATEGORIES
  end

  def calculate
    run_factors
    CATEGORIES.each { |key, value| @overall += @categories[key] unless @categories[key].nil? } if @overall
    @connection.link_score.update!(@categories)
    return 0 unless @overall
    @overall
  end

  def proximity
    begin
      c = :housing
      child_address = child.school_district&.address&.address_1
      contact_address = contact.address&.address_1
      raise NilInfoError.new(c) if child_address.nil? || contact_address.nil? || (!contact_address.nil? && contact_address.strip.empty?)
      proximity = DistanceMatrix.calculate(contact_address, contact_address, c) / 1609
      if proximity <= 10
        increment_score(c, 20)
      elsif proximity > 10 && proximity <= 30
        increment_score(c, 10)
      elsif proximity > 30 && proximity <= 60
        increment_score(c, 5)
      else
        increment_score(c, 0)
      end
    rescue NilInfoError => e
      @nil_categories[e.message.to_sym] -= 1
    rescue ZeroOverallError => e
      @overall = nil
      @categories[e.message.to_sym] = 0
    end
  end

  def criminal_records
    begin
      c = :criminal_history
      criminal_records = RowCounter.count_from_task_id(@connection, "qfpI8LT6l00ylR9dT", c)
      if criminal_records >= 1 && criminal_records < 3
        decrement_score(c, 20)
      elsif criminal_records >= 3 && criminal_records < 5
        decrement_score(c, 40)
      elsif criminal_records >= 5 && criminal_records < 10
        decrement_score(c, 60)
      elsif criminal_records >= 10
        raise ZeroOverallError.new(c)
      end
    rescue NilInfoError => e
      @nil_categories[e.message.to_sym] -= 1
    rescue ZeroOverallError => e
      @overall = nil
      @categories[e.message.to_sym] = 0
    end
  end

  def megans_low
    begin
      c = :criminal_history
      megans_low = RowCounter.count_from_task_id(@connection, "AAn4h8mfBNaKk33Rb", c)
      if megans_low >= 1
        @connection.update!(is_disqualified: true, disqualify_reason: "Pa Megan's Low Registration found") if @connection.is_disqualified != true
        raise ZeroOverallError.new(c)
      end
    rescue NilInfoError => e
      @nil_categories[e.message.to_sym] -= 1
    rescue ZeroOverallError => e
      @overall = nil
      @categories[e.message.to_sym] = 0
    end
  end

  def age
    begin
      c = :demographics
      contact_age = AgeCalculator.calculate(@contact.birthday)
      raise NilInfoError.new(c) unless contact_age
      child_age = AgeCalculator.calculate(@child.birthday)
      raise NilInfoError.new(c) unless child_age
      raise ZeroOverallError.new(c) if contact_age >= 80
      if child_age < 10
        if contact_age >= 65
          decrement_score(c, 40)
        elsif contact_age >= 55 && contact_age < 65
          decrement_score(c, 20)
        elsif contact_age >= 50 && contact_age < 55
          decrement_score(c, 10)
        elsif contact_age >= 25 && contact_age < 40
          increment_score(c, 20)
        elsif contact_age < 21
          raise ZeroOverallError.new(c)
        else
          increment_score(c, 0)
        end
      else
        if contact_age >= 65 && contact_age < 80
          decrement_score(c, 20)
        elsif contact_age >= 55 && contact_age < 65
          decrement_score(c, 10)
        elsif contact_age >= 25 && contact_age < 45
          increment_score(c, 10)
        elsif contact_age < 21
          raise ZeroOverallError.new(c)
        else
          increment_score(c, 0)
        end
      end
    rescue NilInfoError => e
      @nil_categories[e.message.to_sym] -= 1
    rescue ZeroOverallError => e
      @overall = nil
      @categories[e.message.to_sym] = 0
    end
  end

  private
    def increment_score(c, number)
      @categories[c] = 0 unless @categories[c]
      @categories[c] += number
    end

    def decrement_score(c, number)
      @categories[c] = 0 unless @categories[c]
      @categories[c] -= number
    end

    def run_factors
      proximity
      megans_low
      criminal_records
      age
    end

    def contact
      @contact ||= @connection.contact
    end

    def child
      @child ||= @connection.child
    end
end
