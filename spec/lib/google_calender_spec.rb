require 'spec_helper'

class MockGcalEvent
  def summary
    "mock title"
  end
  def description
    "mock description"
  end
end

describe GoogleCalender do
  let(:standup) { create(:standup) }
  let(:gcal_events) { [ MockGcalEvent.new ] }

  before do
    allow_message_expectations_on_nil
  end

   before(:each) do
    Google::APIClient.any_instance.stub_chain(:authorization, :access_token=)
    Google::APIClient.any_instance.stub(:discovered_api)
    Google::APIClient.any_instance.stub_chain(:discovered_api, :calendar_list, :list)
    Google::APIClient.any_instance.stub_chain(:execute, :status).and_return(200)
    Google::APIClient.any_instance.stub_chain(:execute, :data, :items).and_return(gcal_events)
  end

  describe "#events" do

    it "should create events based on google calender events" do
      Item.all.length.should be_zero

      GoogleCalender.events(gcal_events, standup.id)

      event = Item.where(kind: 'Event').first
      item = gcal_events.first

      event.title.should == item.summary
      event.description.should == item.description
    end

    it "should set created event's source tp 'google calender'" do
      GoogleCalender.events(gcal_events, standup.id)

      event = Item.where(kind: 'Event').first
      event.source.should == GoogleCalender::NAME
    end

  end
end
