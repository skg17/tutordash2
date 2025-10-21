module OAuth
    class GoogleOauth2Controller < ApplicationController
        def callback
            auth = request.env['omniauth.auth']
            origin = request.env['omniauth.origin']

            user_account = UserAccount.find_or_initialize_by(
                provider: auth.provider,
                provider_account_id: auth.uid,
            )
            
            # Retrieve user ID from current session
            user_id = session[:user_id]

            user_account.attributes = {
                access_token: auth.credentials.token,
                auth_protocol: 'oauth2',
                expires_at: Time.at(auth.credentials.expires_at).to_datetime,
                refresh_token: auth.credentials.refresh_token,
                scope: auth.credentials.scope,
                token_type: 'Bearer',
                user_id: user_id,
            }

            user_account.save!

            redirect_to origin
        end
    end
end