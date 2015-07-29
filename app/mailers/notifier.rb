class Notifier < ActionMailer::Base

  def statistic statistic
    @daily_statistic = statistic

    mail subject: t('digest.email_header.subject', date: @daily_statistic.for_today),
         to:      User.all.map {|user| user.email},
         bcc:     ENV['BCC'],
         from:    t('digest.email_header.from')
  end

end