class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]


  before_action :admin_only

  # Dont like that this is replicated here and ProtectedController ... but don't see an easy way to include it in both places
  def admin_only
    puts self.view_context.admin_access_level?
    if !self.view_context.admin_access_level?
      redirect_to :back, :alert => "Access Denied"
    end
  end

  alias_method :parent_new, :new

  def new_editor
    puts "XX IN NEW EDITOR"
#    super.new
#    render 'new_editor'#, super.new
    parent_new
  end

  # GET /resource/sign_up
  def new
    puts "XX IN CUSTOM NEW"
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
