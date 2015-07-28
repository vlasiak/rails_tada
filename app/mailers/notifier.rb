class Notifier < ActionMailer::Base

  def statistic
    mail :subject => 'TaDa daily digest for today',
         :to      => 'isnull29@gmail.com',
         :from    => 'no-reply@tada.com'
  end

end
