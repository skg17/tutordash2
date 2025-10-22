class DashboardsController < ApplicationController
  def index
    @students = current_user.students.all

    @lessons = current_user.lessons.includes(:student)

    @total_students = @students.count

    @lessons_this_week = @lessons.where("date >= ? AND date <= ?", Time.current.beginning_of_week, Time.current.end_of_week).count

    @monthly_revenue = @lessons.where(paid: true, date: Time.current.beginning_of_month..Time.current.end_of_month)
                               .sum { |l| l.duration * (l.student&.rate || 0) }

    @outstanding_payments_sum = @lessons.where(paid: false)
                                        .sum { |l| l.duration * (l.student&.rate || 0) }

    @upcoming_lessons = @lessons.where("date > ?", Time.current)
                               .order(date: :asc)
                               .first(5)

    @recent_payments = @lessons.order(date: :desc).first(5)
  end
end
