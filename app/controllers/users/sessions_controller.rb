class Users::SessionsController < Devise::SessionsController
  before_filter :set_flash, only: [:new]

  private

  def set_flash
    @flash = Notifier.new flash
  end
end
