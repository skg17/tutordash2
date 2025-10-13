# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# --- Cleanup ---
puts "Cleaning up existing data..."
Lesson.destroy_all
Student.destroy_all
puts "Clean up complete. Students: #{Student.count}, Lessons: #{Lesson.count}"

# --- Student Data ---

puts "Creating Student records..."

student_one = Student.create!(
  name: "Alex Johnson",
  year: 11,
  current: true,
  subjects: ["Math", "Physics"],
  rate: 65.00,
  grade: "B+",
  target: "A-", # Updated to a simple grade
  parent_name: "Sarah Johnson",
  email: "sarah.j@example.com",
  phone: "555-123-4567"
)

student_two = Student.create!(
  name: "Mia Rodriguez",
  year: 8,
  current: true,
  subjects: ["English", "History"],
  rate: 45.00,
  grade: "C",
  target: "B", # Updated to a simple grade
  parent_name: "Luis Rodriguez",
  email: "luis.r@example.com",
  phone: "555-987-6543"
)

student_three = Student.create!(
  name: "Tom Miller",
  year: 12,
  current: true,
  subjects: ["Chemistry"],
  rate: 70.00,
  grade: "A",
  target: "A+", # Updated to a simple grade
  parent_name: "Jessica Miller",
  email: "jessica.m@example.com",
  phone: "555-333-2222"
)

student_four = Student.create!(
  name: "Kylie Chen",
  year: 9,
  current: false, # Discontinued student
  subjects: ["Spanish"],
  rate: 55.00,
  grade: "B",
  target: "B+", # Updated to a simple grade
  parent_name: "David Chen",
  email: "david.c@example.com",
  phone: "555-777-8888"
)

puts "Created #{Student.count} students."

# --- Lesson Data ---

puts "Creating Lesson records..."

# Lessons for Alex Johnson (Math/Physics)
Lesson.create!([
  {
    student: student_one,
    date: 5.days.ago,
    duration: 1.5,
    subject: "Physics",
    paid: true,
    homework: "Complete kinematics worksheet 3. Review projectile motion notes."
  },
  {
    student: student_one,
    date: 12.days.ago,
    duration: 1.0,
    subject: "Math",
    paid: true,
    homework: "Practice quadratic equations. Focused on completing the square."
  },
  {
    student: student_one,
    date: 20.days.ago,
    duration: 2.0,
    subject: "Physics",
    paid: false,
    homework: "Initial assessment and goal setting. Start forces and motion."
  }
])

# Lessons for Mia Rodriguez (English/History)
Lesson.create!([
  {
    student: student_two,
    date: 3.days.ago,
    duration: 1.0,
    subject: "English",
    paid: false,
    homework: "Draft introduction and first body paragraph for persuasive essay."
  },
  {
    student: student_two,
    date: 10.days.ago,
    duration: 1.0,
    subject: "History",
    paid: true,
    homework: "Read chapter 5: The American Revolution. Outline key figures."
  }
])

# Lessons for Tom Miller (Chemistry)
Lesson.create!([
  {
    student: student_three,
    date: 1.day.ago, # Most recent lesson
    duration: 1.5,
    subject: "Chemistry",
    paid: true,
    homework: "Review stoichiometry calculations. Focus on limiting reactants."
  },
  {
    student: student_three,
    date: 8.days.ago,
    duration: 1.5,
    subject: "Chemistry",
    paid: true,
    homework: "Completed gas laws problems. Assigned practice exam questions 1-10."
  }
])

# Lesson for Kylie Chen (Spanish - discontinued)
Lesson.create!({
  student: student_four,
  date: 6.months.ago,
  duration: 1.0,
  subject: "Spanish",
  paid: true,
  homework: "Final review for oral exam. This was the last scheduled session."
})

puts "Created #{Lesson.count} lessons."
puts "Seed data creation complete!"
