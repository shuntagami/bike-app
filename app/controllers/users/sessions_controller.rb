module Users
  class SessionsController < Devise::SessionsController
    def create
      auth_options = { scope: resource_name, recall: "#{controller_path}#failed" }
      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
      flash[:success] = "#{resource.name}さんおかえりなさい"
    end

    # ログイン失敗の時は直前のURLにリダイレクトする
    def failed
      redirect_to params[:user][:url]
      flash[:notice] = 'メールアドレスまたはパスワードが違います。'
    end

    def destroy
      # rubocop:disable all
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      # rubocop:enable all
      yield if block_given?
      respond_with resource, location: after_sign_out_path_for(resource)
      flash[:success] = 'ログアウトしました'
    end
  end
end
