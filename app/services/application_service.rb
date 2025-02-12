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

  def success(message: "", content: nil)
    respond(
      level: :info,
      message: message,
      status: :success,
      content: content
    )
  end

  def failure(message: "", content: nil)
    respond(
      level: :warn,
      message: message,
      status: :failure,
      content: content
    )
  end

  def respond(level: :unknown, message: "", status: :success, content: nil)
    status = :failure unless ServiceResponse::STATUSES.include? status
    level = :unknown unless LOG_LEVELS.include? level
    log_message = "#{status.to_s.titleize}#{" - #{message}" if message.present?}"
    log(level, log_message)
    ServiceResponse.new(status: status, content: content)
  end
end
