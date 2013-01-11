class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  helper_method :current_user_or_guest

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options(options = {})
      { locale: I18n.locale }
    end

    # if user is logged in, return current_user, else return guest_user
    def current_user_or_guest
      if current_user
        if session[:guest_user_id]
          logging_in
          guest_user.destroy
          session[:guest_user_id] = nil
        end
        current_user
      else
        guest_user
      end
    end

    # find guest_user object associated with the current session,
    # creating one as needed
    def guest_user
      if session[:guest_user_id]
        guest = Guest.where(id: session[:guest_user_id]).first
      end
      guest ||= Guest.create
      session[:guest_user_id] = guest.id
      guest
    end

    # called (once) when the user logs in, insert any code your application needs
    # to hand off from guest_user to current_user.
    def logging_in
      guest_user.friends.update_all(user_id: current_user.id)
      guest_user.bills.update_all(user_id: current_user.id)
      guest_user.participations.update_all(person_id: current_user.id)
    end

    def show_anonymous_warning
      if current_user.nil?
        flash.now[:anonymous_warning] = true
      end
    end
end
