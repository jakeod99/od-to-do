class DashboardController < ApplicationController
  def index
    if @current_wave.present?
      @unassigned = @current_wave.tasks.where(assignable_id: nil).order(urgency: :desc)
      @in_progress = TaskSearchQuery.query(filters: {
        wave: "Current Wave",
        assigned_to: [ @current_user.id ],
        status: [ "in_progress" ],
        order_by_due: :asc
      })
      @today = TaskSearchQuery.query(filters: {
        wave: "Current Wave",
        assigned_to: @current_user.assignable_ids,
        status: [ "unstarted" ],
        due_before: Date.today,
        order_by_due: :asc
      })
      @tomorrow = TaskSearchQuery.query(filters: {
        wave: "Current Wave",
        assigned_to: @current_user.assignable_ids,
        status: [ "unstarted" ],
        due_before: Date.tomorrow,
        due_after: Date.tomorrow,
        order_by_due: :asc
      })
      @other = TaskSearchQuery.query(filters: {
        wave: "Current Wave",
        assigned_to: @current_user.assignable_ids,
        status: [ "unstarted" ],
        order_by_urgency: :desc
      }) - (@today + @tomorrow)
      @completed = @current_wave.tasks.where(completed_by: @current_user)
      @dishonor = TaskSearchQuery.query(filters: {
        wave: "Current Wave",
        assigned_to: @current_user.assignable_ids,
        status: [ "skipped", "failed" ]
      })
    else
      redirect_to new_wave_path
    end
  end
end
