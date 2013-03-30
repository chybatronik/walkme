class RegistrationsController < Devise::RegistrationsController

  # ovverride #create to respond to AJAX with a partial
  def create
    build_resource
    if resource.save
      if resource.active_for_authentication?
        sign_in(resource_name, resource)
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        expire_session_data_after_sign_in!
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      render :action => :new, :layout => !request.xhr?
    end
  end

  def new
    @plan = params[:plan]
    if @plan && ENV["ROLES"].include?(@plan) && @plan != "admin"
      super
    else
      redirect_to root_path, :notice => 'Please select a subscription plan below.'
    end
  end

  def update_plan
    @user = current_user
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    if @user.update_plan(role)
      redirect_to edit_user_registration_path, :notice => 'Updated plan.'
    else
      flash.alert = 'Unable to update plan.'
      render :edit
    end
  end

  def update_card
    @user = current_user
    @user.stripe_token = params[:user][:stripe_token]
    if @user.save
      redirect_to edit_user_registration_path, :notice => 'Updated card.'
    else
      flash.alert = 'Unable to update card.'
      render :edit
    end
  end
  
  private
  def build_resource(*args)
    super
    if params[:plan]
      resource.add_role(params[:plan])
    end
  end
  
  protected

  def after_inactive_sign_up_path_for(resource)
    '/thankyou.html'
  end

  def after_sign_up_path_for(resource)
    # the page new users will see after sign up (after launch, when no invitation is needed)
    redirect_to root_path
  end

end