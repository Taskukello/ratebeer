class SessionsController < ApplicationController
  def new
    # render�i kirjautumissivun
  end

    def create
      user = User.find_by username: params[:username]
     if user && user.authenticate(params[:password])
	#	if (user.status)
	#		redirect_to :back, notice: "Your account is frozen, please contact admin"
	#	else
			session[:user_id] = user.id
			redirect_to user_path(user), notice: "Welcome back!"
	#	end
      else
        redirect_to :back, notice: "Username and/or password mismatch"
      endredirect_to user_path(user), notice: "Welcome back!"
		end
	end
	
  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus p��sivulle
    redirect_to :root
  end
end