class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable



  def self.connect_to_facebook(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      # registered_user = User.where(:email => auth.info.email).first
      registered_user = User.where(:email => auth.uid + "@facebook.com").first
      if registered_user
        return registered_user
      else
        email = auth.uid+"@facebook.com"
        email ||= "example@nil.com"
        # user = User.create(name:auth.info.first_name,
        #                     provider:auth.provider,
        #                     uid:auth.uid,
        #                     email:email,
        #                     password:Devise.friendly_token[0,20],
        #                   )


        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:email,
                            password:Devise.friendly_token[0,20],
                          )
      end

    end
  end 

  # def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
  #   user = User.where(:provider => auth.provider, :uid => auth.uid).first
  #   if user
  #     return user
  #   else
  #     registered_user = User.where(:email => auth.uid + "@twitter.com").first
  #     if registered_user
  #       return registered_user
  #     else

  #       user = User.create(name:auth.extra.raw_info.name,
  #                           provider:auth.provider,
  #                           uid:auth.uid,
  #                           email:auth.uid+"@twitter.com",
  #                           password:Devise.friendly_token[0,20],
  #                         )
  #     end

  #   end
  # end





end
