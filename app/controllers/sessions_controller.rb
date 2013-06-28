class SessionsController < Devise::SessionsController
  # Use json for browserid's Ajax signin
  respond_to :html, :json
end
