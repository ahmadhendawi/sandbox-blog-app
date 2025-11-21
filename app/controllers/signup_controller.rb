class SignupController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path , notice: "Signup successful!"
    else
      flash.now[:alert] = "There were some errors during signup."
      render :new
    end
  end

  private

  def user_params
    params.expect(user: [:name, :email, :password, :password_confirmation])
  end

end
