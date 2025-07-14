class TaskTerminator < ApplicationService
  def call
    @tasks = tasks_to_terminate
    return success message: "No tasks past firm due" if @tasks.count == 0

    begin
      ActiveRecord::Base.transaction do
        fail_tasks
      end
    rescue ActiveRecord::Rollback => e
      return failure message: "Transaction block rollback '#{e.message}'"
    end
    success content: @tasks
  end

  private

  def fail_tasks # would update_all, but using callback
    @tasks.each { |task| task.update(status: "failed") }
  end

  def tasks_to_terminate
    Task.where(firm_due: ..(Date.yesterday), status: [ "unstarted", "in_progress" ])
  end
end
