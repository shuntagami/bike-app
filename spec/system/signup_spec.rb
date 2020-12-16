require 'rails_helper'

RSpec.describe 'Signup', type: :system do
  let!(:user) do
    create(:user,
           name: 'TestUser',
           email: 'test@example.com',
           password: '12345678')
  end

  it '新規ユーザーを作成し、ログインする' do
    visit root_path

    click_link '新規登録'
    # expect(current_path).to eq root_path
    expect(page).to have_content '新規ユーザー登録'

    # 失敗ケース
    fill_in 'ユーザー名（１０文字以内）', with: 'a' * 11
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード（6文字以上）', with: 'password_alice'
    fill_in '確認用パスワード', with: 'password_bob'
    fill_in 'user[bike_attributes][bike_name]', with: ' '
    select '--', from: 'user[bike_attributes][cc_id]'
    select '--', from: 'user[bike_attributes][maker_id]'
    select '--', from: 'user[bike_attributes][type_id]'

    click_button '新規登録'
    expect(page).to have_content 'ユーザー名は10文字以内で入力してください'
    expect(page).to have_content 'メールアドレスはすでに存在します'
    expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
    expect(page).to have_content '車種名を入力してください'
    expect(page).to have_content '排気量は0以外の値にしてください'
    expect(page).to have_content 'メーカーは0以外の値にしてください'
    expect(page).to have_content 'タイプは0以外の値にしてください'

    # 成功ケース
    click_link '新規登録'
    fill_in 'ユーザー名（１０文字以内）', with: 'Alice'
    fill_in 'メールアドレス', with: 'alice@example.com'
    fill_in 'パスワード（6文字以上）', with: 'password_alice'
    fill_in '確認用パスワード', with: 'password_alice'
    fill_in 'user[bike_attributes][bike_name]', with: 'cb1000rr'
    select '400cc~(大型)', from: 'user[bike_attributes][cc_id]'
    select 'ホンダ', from: 'user[bike_attributes][maker_id]'
    select 'ネイキッド', from: 'user[bike_attributes][type_id]'

    expect do
      click_button '新規登録'
      expect(current_path).to eq root_path
      expect(page).to have_content 'Aliceさん'
    end.to change(User, :count).by(1)

    aggregate_failures do
      alice = User.find_by(name: 'alice')
      expect(alice.name).to eq 'Alice'
      expect(alice.email).to eq 'alice@example.com'
    end
  end
end
