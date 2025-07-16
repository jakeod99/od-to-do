class TaskSearcher < ApplicationService
  def initialize(filters: {})
    @filters = filters
  end

  def call
    @tasks = TaskSearchQuery.query(filters: @filters)
    success content: { total_count: @tasks.count, tasks: @tasks.limit(24) }
  end
end
