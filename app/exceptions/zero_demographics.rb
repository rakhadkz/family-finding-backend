class ZeroDemographics < ArgumentError
  def initialize(msg = "Zero Demographics")
    super(msg)
  end
end
