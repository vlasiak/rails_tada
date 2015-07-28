class Notifier < ActionMailer::Base

  def statistic daily_statistic
    @daily_statistic = daily_statistic
    mail subject: t('digest.email_header.subject', date: @daily_statistic.for_yesterday),
         to: 'isnull29@gmail.com',
         from: t('digest.email_header.from')
  end

end