require 'sinatra'
require 'xmlsimple'
require 'logger'

class PivotalHookService < Sinatra::Base
 
  configure do
    LOGGER = Logger.new("log/messages.log") 
  end
 
  helpers do
    def logger
      LOGGER
    end
  end
  
  get '/hello' do
    "hello"
  end

  post '/monkey/:chat_blob' do
    xml = request.body.read
  
    doc = XmlSimple.xml_in(xml)
    case doc["event_type"].to_s
    when "story_create", "note_create", "story_update"
      message = doc["description"]
    else
      message = "ubdefined"
    end
    logger.info "Chat: #{params[:chat_blob]}, message #{message}"
  end
end
