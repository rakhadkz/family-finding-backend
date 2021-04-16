class ZeroOverallError < LinkScoreError
  def initialize(category = nil)
    super(category)
  end
end
