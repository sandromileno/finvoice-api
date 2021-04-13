class BaseError < StandardError
  attr_reader :errors

  def initialize(message)
    @errors = []
    @errors << message
  end
end