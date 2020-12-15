require 'rails_helper'

RSpec.describe 'Login', type: :system do
  let!(:user) do
    create(:user,
           name: 'TestUser',
           email: 'test@example.com',
           password: '12345678')
  end

  describe '通常ユーザー' do
    it '通常ユーザーがログイン/ログアウトする' do
      visit root_path

      # ログインページへ移動する
      click_link 'ログイン'
      expect(current_path).to eq root_path
      expect(page).to have_content '次回から自動的にログイン'

      # 失敗ケース
      fill_in 'メールアドレス', with: 'alice@example.com'
      fill_in 'パスワード', with: 'password_alice'
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'

      # 成功ケース
      click_link 'ログイン'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: '12345678'
      click_button 'ログイン'
      expect(current_path).to eq root_path
      expect(page).to have_content 'TestUserさん'

      # ログアウトする
      click_link 'TestUserさん'
      click_link 'ログアウト'

      expect(page).to_not have_content 'TestUserさん'
      expect(page).to have_link '新規登録'
      expect(page).to have_link 'ログイン'
    end
  end

  describe 'ゲストユーザー' do
    let!(:guest) { create(:user, :guest) }

    it 'ゲストユーザーとしてログインする' do
      visit root_path

      click_link 'ログイン'
      fill_in 'メールアドレス', with: 'guest@example.com'
      fill_in 'パスワード', with: '12345678'
      click_button 'ログイン'
      expect(current_path).to eq root_path
      expect(page).to have_content 'GuestUserさん'
    end

    it 'かんたんログインができる(ゲストユーザーとしてログイン)' do
      visit root_path

      click_link 'ログイン'
      click_button 'かんたんログイン'
      expect(current_path).to eq root_path
      expect(page).to have_content 'GuestUserさん'
    end
  end
end
