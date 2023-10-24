class TopController < ApplicationController
  def main
    if session[:login_uid] != nil
      render "main"
    else
      render "login"
    end
  end

  def login
    user = User.find_by(uid: params[:uid])
    if user != nil
      if BCrypt::Password.new(user.pass) == params[:pass]
        session[:login_uid] = params[:uid]
        redirect_to top_main_path
      else
        render "error"
      end
    else
      render "error"
    end
  end
  
  def logout
    session.delete(:login_uid)
    redirect_to top_main_path
  end
  
  def newuser
    render "newuser"
  end
  
  def saveuser
    if User.find_by(uid: params[:uid])
      render "exist_error"
    else
      User.create(uid: params[:uid], pass: BCrypt::Password.create(params[:pass]))
      render "registered"
    end
  end
end