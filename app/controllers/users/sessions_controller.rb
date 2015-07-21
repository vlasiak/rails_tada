class Users::SessionsController < Devise::SessionsController

  def new
    @flash_message = FlashNotification.new flash
    super
  end

end
