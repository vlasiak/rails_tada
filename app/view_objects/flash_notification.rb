class FlashNotification

  def initialize flash_message
    @flash_message = flash_message
  end

  def alert
    flash_message[:alert] unless flash_message[:alert].blank?
  end

  private

  attr_reader :flash_message

end