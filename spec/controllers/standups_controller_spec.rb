require 'rails_helper'

describe StandupsController do
  let(:standup) { create(:standup) }

  before do
    request.session[:logged_in] = true
  end

  describe "#create" do
    context "with valid params" do
      it "creates a standup" do
        expect do
          post :create, standup: {title: "Berlin", to_address: "berlin+standup@pivotallabs.com"}
        end.to change { Standup.count }.by(1)
        response.should be_redirect
      end
    end

    context "with invalid params" do
      it "creates a standup" do
        expect do
          post :create, standup: {}
        end.to change { Standup.count }.by(0)
        response.should render_template 'standups/new'
      end
    end
  end

  describe "#new" do
    it "renders the new standups template" do
      get :new
      response.should be_ok
      response.should render_template 'standups/new'
    end
  end

  describe "#index" do
    context 'when the user is logged in' do
      it 'renders an index of all of the standups' do
        standup1 = create(:standup)
        standup2 = create(:standup)

        get :index

        response.should be_ok
        expect(assigns[:standups]).to include(standup1, standup2)
      end
    end

    context 'when the user is not logged in' do
      before do
        request.stub(:remote_ip) { '0.0.0.9' }
        request.session[:logged_in] = false
      end

      it 'renders an index of all the standups' do
        standup1 = create(:standup, ip_addresses_string: '0.0.0.9')
        standup2 = create(:standup, ip_addresses_string: '0.0.0.8')

        get :index

        response.should be_ok
        expect(assigns[:standups]).to include standup1, standup2
      end
    end

    it 'sorts all standups alphabetically' do
      second = create(:standup, title: 'Bravo Badger')
      first = create(:standup, title: 'Alpha Aardvark')
      fourth = create(:standup, title: 'ZULU Zebra')
      third = create(:standup, title: 'Zooloo Zebra')

      get :index

      response.should be_ok
      expect(assigns[:standups]).to eq [first, second, third, fourth]
    end
  end

  describe "#edit" do
    it "shows the post for editing" do
      get :edit, id: standup.id
      assigns[:standup].should == standup
      response.should be_ok
    end
  end

  describe "#show" do
    it "redirects to the items page of the standup" do
      get :show, id: standup.id
      response.body.should redirect_to standup_items_path(standup)
    end

    it 'saves standup id to cookie' do
      get :show, id: standup.id
      expect(session[:last_visited_standup]).to eq(standup.id.to_s)
    end
  end

  describe "#update" do
    context "with valid params" do
      it "updates the post" do
        put :update, id: standup.id, standup: {title: "New Title"}
        standup.reload.title.should == "New Title"
      end
    end

    context "with invalid params" do
      it "does not update the post" do
        put :update, id: standup.id, standup: {title: nil}
        standup.reload.title.should == standup.title
        response.should render_template 'standups/edit'
      end
    end
  end

  describe "#destroy" do
    let!(:standup) { create(:standup) }

    it "destroys the specified standup" do
      expect {
        post :destroy, id: standup.id
      }.to change(Standup, :count).by(-1)
      response.should redirect_to standups_path
    end
  end

  describe '#last_or_index' do
    context 'when user has never visited whiteboard' do
      it 'redirects to index' do
        session[:last_visited_standup] = nil

        get :last_or_index

        expect(response).to redirect_to(standups_path)
      end
    end

    context 'when user has previously visited a standup' do
      it 'redirects to index' do
        session[:last_visited_standup] = 30

        get :last_or_index

        expect(response).to redirect_to(standup_path(30))
      end
    end
  end

end
