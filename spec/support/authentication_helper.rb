def bypass_controller_login
  allow_any_instance_of(ApplicationController).to receive(:authenticate_user!) {true}
end

def log_in_to_okta(email)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:saml] = OmniAuth::AuthHash.new(
    {
      info: {
        name: 'trolllllllllll'
      }
    }
  )
end
