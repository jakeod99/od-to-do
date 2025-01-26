# For thoughts on Service Object design in Rails:
# https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial

class ApplicationService
  def self.call(**)
    Rails.logger.info "#{name}: Started"
    new(**).call
  end

  def call
    raise NotImplementedError
  end

  private

  LOG_LEVELS = [ :debug, :info, :warn, :error, :fatal, :unknown ].freeze

  def log(level, message)
    level = :unknown unless LOG_LEVELS.include? level
    Rails.logger.send(level, "#{self.class.name}: " + message)
  end

  def success(content = nil)
    log(:info, "Succeeded")
    ServiceResponse.new(status: :success, content: content)
  end

  def failure(content = nil)
    log(:warn, "Failed")
    ServiceResponse.new(status: :failure, content: content)
  end
end
