class ZeroFinancial < ArgumentError
  def initialize(msg = "Zero Financial")
    super(msg)
  end
end
