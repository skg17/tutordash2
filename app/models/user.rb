class User < ApplicationRecord
    has_secure_password
    has_many :user_accounts, dependent: :destroy

    # Simple email validation
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

    # Requires at least 8 characters, one lowercase, one uppercase, one digit, and one special character.
    VALID_PASSWORD_REGEX = /\A
    (?=.{8,})          # Minimum 8 characters
    (?=.*[a-z])        # At least one lowercase letter
    (?=.*[A-Z])        # At least one uppercase letter
    (?=.*\d)           # At least one digit
    (?=.*[[:^alnum:]]) # At least one special character
    /x

    validates :password,
            presence: { if: :password_required? },
            format: { with: VALID_PASSWORD_REGEX, message: "must be at least 8 characters long and include an uppercase letter, a lowercase letter, a digit, and a special character." },
            if: :password_required?

    def google_connected?
        google_account = self.user_accounts.find_by(provider: 'google_oauth2')
        google_account&.connected?
    end
  
    has_many :students, dependent: :destroy
    has_many :lessons, through: :students

    private

    # Helper to require password only on creation or if it's explicitly changing
    def password_required?
        new_record? || password.present?
    end
end