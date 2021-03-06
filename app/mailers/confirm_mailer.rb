class ConfirmMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.confirm_mailer.sendmail_event.subject
  #
  def sendmail_event(c_id)
    if @circle = Circle.find_by(id: c_id)
      @event_term = EventTerm.find(2)
      @events = @circle.events.where("date >= ?", @event_term.start_date)
      @events = @events.where("date <= ?", @event_term.finish_date)
      @st_date = @event_term.start_date.strftime('%m月%d日')
      @fn_date = @event_term.finish_date.strftime('%m月%d日')
      mail(
      to:      "#{@circle.email}",
      subject: "【要確認】新歓MiXイベント情報について",
      from: "新歓MiX編集部",
      ) do |format|
        format.text
        end
    end
  end
end
