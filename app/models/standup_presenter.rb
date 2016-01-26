class StandupPresenter < SimpleDelegator
  STANDUP_CLOSINGS = [
      "STRETCH!",
      "STRETCH! It's good for you!",
      "STRETCH!!!!!"
  ]

  def initialize(standup)
    @standup = standup
    __setobj__(standup)
  end

  def closing_message
    return @standup.closing_message if @standup.closing_message.present?
    return "STRETCH! It's Floor Friday!" if Time.zone.today.wday == 5
    return nil if @standup.image_urls.present?

    STANDUP_CLOSINGS.sample
  end

  def create_post_button_text
    "Send Email"
  end

  def create_post_confirm_message
    "You are about to send today's stand up email. Continue?"
  end

  def create_post_sender_field_placeholder
    "Standup host(s)"
  end

  def create_post_subject_field_placeholder
    "Email subject"
  end

  def closing_image
    return nil unless @standup.image_days.include? @standup.date_today.strftime("%a")
    @standup.image_urls.split("\n").reject(&:blank?).sample
  end
end
