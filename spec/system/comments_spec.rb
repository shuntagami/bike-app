require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let!(:user) do
    create(:user,
           name: 'TestUser',
           email: 'test@example.com',
           password: '12345678')
  end
  let!(:post) { create(:post) }

  it '既存の投稿にコメントをして、削除をする', js: true do
    visit root_path

    # ログインする
    click_link 'ログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content '次回から自動的にログイン'

    fill_in 'login_email', with: 'test@example.com'
    fill_in 'login_password', with: '12345678'
    click_button 'ログイン'
    expect(current_path).to eq root_path

    # 投稿詳細へ移動する
    click_link '新 着 投 稿'
    expect(page).to have_link 'a', href: "/posts/#{post.id}"
    find('.img').click
    expect(current_path).to eq "/posts/#{post.id}"

    # コメントを投稿する
    fill_in 'comment[text]', with: 'こんにちは^_^.'
    click_button '送信'
    expect(page).to have_content 'こんにちは^_^.'

    fill_in 'comment[text]', with: 'おはようございます。'
    click_button '送信'
    expect(page).to have_content 'おはようございます。'

    # コメントを削除する
    comment = post.comments.find_by!(text: 'こんにちは^_^.')
    delete_link = find_link '削除', href: "/posts/#{post.id}/comments/#{comment.id}"

    page.accept_confirm 'コメントを削除してもよろしいですか？' do
      delete_link.click
    end
    expect(page).to have_content 'コメントが削除されました'
    expect(Comment.where(id: comment.id)).to be_empty
  end
end
