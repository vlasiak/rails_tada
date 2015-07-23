class Users::SessionsController < Devise::SessionsController
  before_filter :set_flash, only: [:new]

  private

  def set_flash
    @notification = FlashNotification.new flash
  end
end
