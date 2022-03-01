class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	# we can add new parameters to the permitted list using the permit method in a before_action method,for instance.
	before_action :configure_permitted_parameters, 
	               if: :devise_controller?


    # permit(action, keys: nil, except: nil, &block) ⇒ Object
    # action - A Symbol with the action that the controller is performing, like sign_up, sign_in, etc.
    # keys: - An Array of keys that also should be permitted.

	protected 

	def configure_permitted_parameters
		# Adding new parameters to be permitted in the `sign_up` action.
		devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
		# Adding new parameters to be permitted in the `account_update` action.
		devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
	end
end
