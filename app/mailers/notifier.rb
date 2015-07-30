class Notifier < ActionMailer::Base
  def digest params
    @daily_statistic = params

    mail subject: t('digest.email_header.subject', date: @daily_statistic.for_today),
         to: @daily_statistic.recipients,
         bcc: Settings.bcc,
         from: t('digest.email_header.from')
  end
end