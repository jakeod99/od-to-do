require "redis"

redis_config = Rails.application.config_for(:redis)

REDIS = Redis.new(
  url: redis_config[:url],
  driver: :hiredis
)
