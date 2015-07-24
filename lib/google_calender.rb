class GoogleCalender
  NAME = 'google calender'

  def self.events(token, standup_id)
    standup = Standup.find_by_id(standup_id)

    client = Google::APIClient.new
    client.authorization.access_token = token
    service = client.discovered_api('calendar', 'v3')

    response = client.execute(
      :api_method => service.calendar_list.list,
      :parameters => {},
      :headers => {'Content-Type' => 'application/json'})

    parse(response, standup)
  end

  private

  def self.parse(gcal_response, standup)

    if gcal_response.status == 200
      items = gcal_response.data.items

      items.each_with_index do |item, index|
        event = Item.new do |i|
          i.standup = standup
          i.kind = 'Event'
          i.title = item.summary
          i.date = Date.today
          i.description = item.description
          i.source = NAME
          i.gcal_event_id = item.etag
        end

        event.save
      end
    end
  end
end
