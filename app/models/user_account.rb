class UserAccount < ApplicationRecord
    belongs_to :user

    def expired?
        expires_at < Time.zone.now
    end

    def connected?
        provider == 'google_oauth2' && provider_account_id.present? && access_token.present?
    end
end
