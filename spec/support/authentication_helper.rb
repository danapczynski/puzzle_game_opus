module AuthenticationHelper
  def login(user = true)
    ApplicationController.any_instance.stub(:current_user) { user }
    ApplicationController.any_instance.stub(:logged_in?) { user }
  end
end
