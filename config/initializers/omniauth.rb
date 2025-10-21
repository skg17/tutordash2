Rails.application.config.middleware.use OmniAuth::Builder do
    configure do |config|
        config.path_prefix = '/oauth'
        config.logger = Rails.logger if Rails.env.development?
    end

    provider :google_oauth2,
        ENV['GOOGLE_CLIENT_ID'],
        ENV['GOOGLE_CLIENT_SECRET'],
        {
            include_granted_scopes: true,
            scope: 'email, profile, https://www.googleapis.com/auth/calendar',
            access_type: 'offline',
            prompt: 'consent',
        }
end