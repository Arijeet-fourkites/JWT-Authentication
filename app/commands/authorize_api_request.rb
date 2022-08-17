class AuthorizeApiRequest
    prepend SimpleCommand
  
    def initialize(headers = {})
      @headers = headers
    end
  
    def call
      user
    end
  
    private
  
    attr_reader :headers
    
  
    def user
      @user ||= User.find(token_decoded[:user_id]) if token_decoded
      @user || errors.add(:token, 'Invalid token') && nil
    end
  
    def token_decoded
      @token_decoded ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
        if headers['Authorization'].present?
          return headers['Authorization'].split(' ').last
        else
          errors.add(:token, 'Missing token')
        end
        nil
      end
    end