class LinebotController < ApplicationController
  require 'line/bot'
  protect_from_forgery :except => [:callback]

  def callback
    body = request.body.read
    @stic = Sticker.all

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
    events = client.parse_events_from(body)
    events.each { |event|

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message['text'] =='スタンプ頂戴！'
            @stic.order("RANDOM()").first
            message = {
              type: 'sticker',
              "stickerId" => @stic.sticId,
              "packageId" => @stic.packId
            }
            response = client.reply_message(event['replyToken'], message)
            p response
          else
            message = {
              type: 'text',
              text: event.message['text']
            }
            response = client.reply_message(event['replyToken'], message)
            p response
          end
        end
      end
    }
    head :ok
  end

  private
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
