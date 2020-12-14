require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  before do
    @alice = create(:user, name: 'Alice', email: 'alice@example.com', password: 'password_alice')
    @alice_bike = @alice.create_bike(
      bike_name: 'cb400',
      cc_id: 1,
      maker_id: 1,
      type_id: 1
    )
    @bob = create(:user, name: 'Bob', email: 'bob@example.com', password: 'password_bob')
    @bob_bike = @bob.create_bike(
      bike_name: 'cb400sf',
      cc_id: 1,
      maker_id: 1,
      type_id: 1
    )
  end

  let!(:bob_post) do
    create(:post, user: @bob)
  end

  it 'ユーザーをフォロー/フォロー解除する', js: true do
    visit root_path

    # Aliceがログインする
    click_link 'ログイン'
    expect(current_path).to eq root_path
    expect(page).to have_content '次回から自動的にログイン'

    fill_in 'メールアドレス', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password_alice'
    click_button 'ログイン'
    expect(current_path).to eq root_path

    # Bobのページへ移動する
    # click_link '新着投稿'
    expect(page).to have_link 'a', href: "/posts/#{bob_post.id}"
    click_link 'Bob'
    expect(current_path).to eq "/users/#{@bob.id}"

    # Bobをフォローする
    expect(page).to have_content 'フォロワー 0人'
    expect do
      click_link 'フォロー'
      expect(page).to have_content 'フォロワー 1人'
      expect(page).to_not have_content 'フォロワー 0人'
      expect(page).to have_content 'フォロー中'
    end.to change(@alice.following, :count).by(1) &
           change(@bob.followers, :count).by(1)

    # マイページ(Alice)に移動する
    visit user_path(@alice)
    expect(current_path).to eq "/users/#{@alice.id}"
    click_link 'フォロー'
    expect(page).to have_content 'フォロー 1人'
    expect(page).to have_content 'Bob'
    expect(page).to have_content 'フォロー中'

    # Bobのフォローを解除する
    expect do
      click_link 'フォロー中'
      expect(page).to have_content 'フォロー 0人'
      expect(page).to_not have_content 'フォロー 1人'
      expect(page).to have_content 'フォロー'
    end.to change(@alice.following, :count).by(-1) &
           change(@bob.followers, :count).by(-1)

    visit user_path(@alice)
    click_link 'フォロー'
    expect(find('.tab-content')).to_not have_content 'Bob'
    expect(page).to have_content '誰もフォローしていません'

    # Bobのユーザーページに移動する
    visit user_path(@bob)
    click_link 'フォロワー'
    expect(find('.tab-content')).to_not have_content 'Alice'
    expect(page).to have_content 'フォローされていません'
  end
end
