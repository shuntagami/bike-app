require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe '#new' do
    context '未ログイン状態のとき' do
      it 'トップページにリダイレクトされること' do
        get new_post_path
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/'
      end
    end
  end

  describe '#create' do
    context '未ログイン状態のとき' do
      it 'トップページにリダイレクトされること' do
        post_params = attributes_for(:post)
        post posts_path, params: { post: post_params }
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/'
      end
    end
  end

  describe '#edit' do
    context '未ログイン状態のとき' do
      it 'トップページにリダイレクトされること' do
        post = create(:post)
        get edit_post_path(post)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/'
      end
    end

    context '認可されていないユーザーがアクセスした場合' do
      # 投稿者とログインユーザーが異なる場合
      it '一覧ページにリダイレクトされること' do
        # ex)posts/1/editに直接URLを叩くと投稿者でないのに入れて編集できてしまうのは良くない
        # correct_userで対処
        user = create(:user)
        user_post = create(:post, user: user)

        another_user = create(:user)
        sign_in another_user

        get edit_post_path(user_post)
        expect(response).to redirect_to '/'
      end
    end
  end

  describe '#update' do
    context '未ログイン状態のとき' do
      it 'トップページにリダイレクトされること' do
        post = create(:post)
        get edit_post_path(post)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/'
      end
    end
  end

  describe '#destroy' do
    let!(:post) { create(:post) }

    context '未ログイン状態のとき' do
      it 'トップページにリダイレクトされること' do
        delete post_path(post)
        expect(response).to have_http_status 302
        expect(response).to redirect_to '/'
      end
    end

    context '認可されていないユーザーがアクセスした場合' do
      it '投稿を削除できず、トップページにリダイレクトされること' do
        another_user = create(:user)
        sign_in another_user
        expect { delete post_path(post) }.to change { Post.count }.by(0)
        expect(response).to redirect_to root_path
      end
    end
  end
end
