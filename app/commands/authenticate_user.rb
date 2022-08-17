class AuthenticateUser
    prepend SimpleCommand
  
    def initialize(email, password,mobile)
      @email = email
      @mobile = mobile
      @password = password
      
    end
  
    def call
      JsonWebToken.encode(user_id: user.id) if user
    end
  
    private
  
    attr_accessor :email, :mobile, :password
  
    def user
      user = User.find_by_email(email)
      return user if user && user.authenticate(password)
  
      errors.add :user_authentication, 'Credentials are Invalid, Please check again'
      nil
    end
  end