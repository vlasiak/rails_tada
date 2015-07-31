class Notifier < ActionMailer::Base
  def digest options
    @daily_statistic = options

    mail subject: t('digest.email_header.subject', date: @daily_statistic.for_today),
         to: @daily_statistic.recipients,
         bcc: Figaro.env.bcc,
         from: t('digest.email_header.from')
  end
end