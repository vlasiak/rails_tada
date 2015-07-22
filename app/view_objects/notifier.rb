class Notifier

  def initialize flash
    @flash = flash
  end

  def alert_present?
    flash[:alert].present?
  end

  def alert
    flash[:alert]
  end

  private

  attr_reader :flash

end