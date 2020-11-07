class Users::SessionsController < Devise::SessionsController
  # def new_guest
  #   user = User.guest
  #   sign_in user
  #   redirect_to root_path
  #   flash[:success] = 'ゲストユーザーとしてログインしました。'
  # end

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
    flash[:notice] = 'emailアドレスまたはパスワードが違います'
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    yield if block_given?
    respond_with resource, location: after_sign_out_path_for(resource)
    flash[:success] = 'ログアウトしました'
  end
end
