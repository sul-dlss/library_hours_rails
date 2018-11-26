# frozen_string_literal: true

class FeedbackMailer < ActionMailer::Base
  def submit_feedback(params, ip)
    @name = params[:name].presence || 'No name given'

    @email = params[:to].presence || 'No email given'

    @message = params[:message]
    @url = params[:url]
    @ip = ip
    @user_agent = params[:user_agent]
    @viewport = params[:viewport]

    mail(to: Settings.EMAIL_TO,
         subject: 'Feedback from SearchWorks',
         from: 'feedback@searchworks.stanford.edu',
         reply_to: Settings.EMAIL_TO)
  end
end
