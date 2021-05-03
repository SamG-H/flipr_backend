class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  SECRET = ENV['MY_SECRET']

  def encode_token(payload)
    JWT.encode(payload, SECRET)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, SECRET, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        []
      end
    end
  end
end
