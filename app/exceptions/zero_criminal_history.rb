class ZeroCriminalHistory < ArgumentError
  def initialize(msg = "Zero Demographics")
    super(msg)
  end
end
