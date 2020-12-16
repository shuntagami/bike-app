require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let!(:user) do
    create(:user,
           :with_posts)
  end
  let!(:alice) do
    create(:user,
           name: 'Alice',
           email: 'alice@example.com',
           password: 'password_alice')
  end

  it '既存の投稿にいいね/いいね解除する', js: true do
    visit root_path

    # Aliceがログインする
    click_link 'ログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content '次回から自動的にログイン'

    fill_in 'login_email', with: 'alice@example.com'
    fill_in 'login_password', with: 'password_alice'
    click_button 'ログイン'
    expect(current_path).to eq root_path

    # 記事詳細へ移動する
    # click_link '新着投稿'
    post = user.posts.first
    expect(page).to have_link 'a', href: "/posts/#{post.id}"
    find('.img').click
    expect(current_path).to eq "/posts/#{post.id}"

    # 投稿にいいね！する
    expect(page).to have_selector '.far'
    expect do
      click_link('like_button')
      expect(page).to have_selector '.fas'
      expect(page).to_not have_selector '.far'
    end.to change(post.likes, :count).by(1)

    # # # マイページに移動する→記事詳細へ移動する
    visit user_path(alice)
    expect(current_path).to eq "/users/#{alice.id}"
    expect(page).to have_content 'いいね 1件'
    click_link 'いいね 1件'
    find('.img').click
    expect(current_path).to eq "/posts/#{post.id}"

    # # # いいね！解除する
    expect(page).to have_selector '.fas'
    expect do
      click_link('like_button')
      expect(page).to have_selector '.far'
    end.to change(post.likes, :count).by(-1)

    # # # マイページに移動する
    visit user_path(alice)
    expect(page).to_not have_content 'いいね 1件'
    expect(page).to have_content 'いいね 0件'
  end
end
