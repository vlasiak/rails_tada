class NotifierPreview < ActionMailer::Preview

  def statistic
    Notifier.statistic
  end

end