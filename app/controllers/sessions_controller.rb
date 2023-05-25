class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # authenticate the user
    # 1. try to find the user by their unique identifier
    @user = User.find_by({"email" => params["email"]})
    if @user
      password_typed= params["password"]
      password_db = @user["password"]
      if BCrypt::Password.new(password_db) == password_typed
        flash["notice"] = "Yes!"
        redirect_to "/companies"
      else
        flash["notice"] = "NOPE"
        redirect_to "/sessions/new"
      end
    else
        flash["notice"] = "NOPE"  
    end
    # 2. if the user exists -> check if they know their password
    # 3. if they know their password -> login is successful
    # 4. if the email does not exist or they do not know their password -> login fails
    flash["notice"] = "Nope."
  end

  def destroy
    # logout the user
    flash["notice"] = "Goodbye."
    redirect_to "/sessions/new"
  end
end
