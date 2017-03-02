require 'yaml'
require 'twilio-ruby'

module Notifier
  def self.send_sms(sms_body, username)
    
    image_url = "https://www.legalserver.org/assets/news/twilio-logo.png"
    # client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    users_list = YAML.load_file('config/users.yml')
    user = users_list.select {|u| user.username == username}.first

    puts "Sending SMS to #{phone_number}, #{sms_body}"

    phone_number = user['phone_number']
    # send_sms(client, phone_number, sms_body, image_url)
  end

  def self.send_sms(client, phone_number, sms_body, image_url)
    twilio_number = ENV['TWILIO_NUMBER']
    message = client.account.messages.create(
      from: twilio_number,
      to: phone_number,
      body: sms_body,
      media_url: image_url
    )
    puts "An SMS notifying the last application error was "\
         "sent to #{message.to[0...-4] + "****"}"
  end

  private_class_method :send_sms
end
