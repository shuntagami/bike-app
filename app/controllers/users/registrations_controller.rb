module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
          flash[:success] = "ようこそ！#{resource.name}さん"
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        redirect_to root_path, flash: {
          user: resource,
          error_messages: resource.errors.full_messages
        }
      end
    end
  end
end
