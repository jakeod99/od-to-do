class ServiceResponse
  STATUSES = [ :success, :failure ].freeze

  attr_reader :status, :content

  def initialize(status:, content: nil)
    unless STATUSES.include? status
      raise ArgumentError.new("ServiceResponse#initialize: unexpected status #{status.inspect}")
    end
    @status = status
    @content = content
  end

  def success?
    @status == :success
  end

  def failure?
    @status == :failure
  end
end
