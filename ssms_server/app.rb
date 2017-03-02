require 'sinatra/base'
require_relative './lib/notifier'
require_relative './lib/encrypter'
require_relative './lib/database'

ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

module ServerNotifications

  class App < Sinatra::Base
    register Sinatra::ConfigFile

    # Dirty config for local files  
    config_file 'config/config.yml'
    ENV['TWILIO_ACCOUNT_SID'] ||= settings.twilio_account_sid
    ENV['TWILIO_AUTH_TOKEN'] ||= settings.twilio_auth_token
    ENV['TWILIO_NUMBER'] ||= settings.twilio_number

    set :show_exceptions, true
    set :raise_errors, true
    set :root, File.dirname(__FILE__)

    db = Database.new

    get '/' do
      @users = db.all_users
      erb :index, :layout => :layout
    end

    get '/users' do
      # Awesome presentation skills
      @users = db.all_users
      erb :all_users, :layout => :layout
    end

    post '/send_sms' do
      public_key = public_key(params[:username])
      sms_body = "Encrypted message. Decode with Twilio's SSMS"\
      "#{message}"
      Notifier.send_sms(sms_body, client_id)
    end

    get '/upload_key' do
      erb :upload_key, :layout => :layout
    end

    post '/upload_key' do
      db.store_public_key(
        params[:username], 
        params[:phone_number],
        params[:public_key]
      )
      @error = "Key stored for #{params[:username]}"

      #don't know how to redirect
      @users = db.all_users
      erb :index, :layout => :layout
    end
  end
end
