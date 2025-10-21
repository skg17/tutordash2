class AssignExistingStudentsToUser < ActiveRecord::Migration[8.0]
  class User < ApplicationRecord; end
  class Student < ApplicationRecord; end

  def up
    # Find or create a specific user
    # NOTE: If you know a user ID already exists, use that ID directly.
    admin_user = User.find_by(email: 'demo@example.com')

    if admin_user.nil?
      # If no users exist, create a safe default one.
      admin_user = User.create!(
        email: 'demo@example.com',
        password: SecureRandom.hex(10),
        # Add any other required columns here
      )
    end

    # Assign all students currently missing a user_id to the admin user
    Student.where(user_id: nil).update_all(user_id: admin_user.id)
  end
end
