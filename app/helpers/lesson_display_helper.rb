module LessonDisplayHelper
  # --- 1. STATUS & PAYMENT PILL DATA ---
  # Returns a hash with status_text, status_class, paid_text, and paid_class
  def lesson_status_and_payment_data(lesson)
    # Determine Lesson Status (Upcoming/Completed)
    if lesson.date && lesson.date > Time.current
      status_text = "Upcoming"
      status_class = "bg-blue-100 text-blue-800 border border-blue-200"
    else
      status_text = "Completed"
      status_class = "bg-gray-100 text-gray-600 border border-gray-200"
    end

    # Determine Payment Status (Paid/Unpaid)
    if lesson.paid?
      paid_text = "Paid"
      paid_class = "bg-green-100 text-green-800 border border-green-200"
    else
      paid_text = "Unpaid"
      paid_class = "bg-orange-100 text-orange-800 border border-orange-200"
    end

    # Return all data as a hash
    {
      status_text: status_text,
      status_class: status_class,
      paid_text: paid_text,
      paid_class: paid_class
    }
  end

  # --- 2. DATE & TIME FORMATTING ---
  # Returns a hash with formatted date (DD/MM/YYYY) and time range (HH:MM - HH:MM)
  def format_lesson_timing(lesson)
    if lesson.date.present? && lesson.duration.present?
      formatted_date = lesson.date.strftime("%d/%m/%Y")
      start_time = lesson.date.strftime("%H:%M")
      end_datetime = lesson.date + lesson.duration.hours
      end_time = end_datetime.strftime("%H:%M")
      time_range = "#{start_time} - #{end_time}"
    else
      formatted_date = "N/A"
      time_range = "N/A"
    end

    { formatted_date: formatted_date, time_range: time_range }
  end
end
