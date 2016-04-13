class PostMailer < ActionMailer::Base
  helper :application

  def send_to_all(post, to_addresses, from_address, standup_id)
    @post = post
    @standup_id = standup_id
    @standup = Standup.find(standup_id)
    @items = post.items_by_type
    @include_authors = true
    mail  :to => Array(to_addresses),
          :subject => post.title_for_email,
          :from => "#{post.from} <#{from_address}>"
  end
end
