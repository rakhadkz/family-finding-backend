class NilInfoError < LinkScoreError
  def initialize(category = nil)
    super(category)
  end
end
