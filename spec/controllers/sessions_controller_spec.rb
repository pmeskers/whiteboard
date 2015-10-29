require 'rails_helper'

describe SessionsController do
  describe '#create' do
    before { ActionController::Base.any_instance.should_receive(:verify_authenticity_token).never }

    it "sets the session['logged_in'] to true" do
      request.env['omniauth.auth'] = { 'info' => { 'name' => 'Kocher' } }
      post :create
      expect(request.session['logged_in']).to eq true
    end

    it "sets the session['username'] to the current user's name" do
      request.env['omniauth.auth'] = { 'info' => { 'name' => 'Dennis' } }
      post :create
      expect(request.session['username']).to eq 'Dennis'
    end
  end

  describe '#destroy' do
    it "sets the session['logged_in'] to false" do
      request.session['logged_in'] = true
      delete :destroy
      expect(request.session['logged_in']).to eq false
    end
  end
end
