require 'rails_helper'

describe SessionsController do
  it 'routes to logout' do
    get('/logout').should route_to('sessions#destroy')
  end

  it 'routes to create' do
    post('/auth/saml/callback').should route_to(:controller => 'sessions', :action => 'create')
  end
end
