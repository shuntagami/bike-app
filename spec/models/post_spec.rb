require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  it '有効なファクトリを持つこと' do
    expect(post).to be_valid
  end

  it '説明、画像、ユーザー、都道府県、市区町村、天気、体感、路面の状態がある場合、有効であること' do
    user = create(:user)
    prefecture = create(:prefecture)
    city = create(:city)
    post = Post.new(
      description: '今日はツーリング日和です',
      image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/rspec_test.jpg')),
      user: user,
      prefecture: prefecture,
      city: city,
      weather: '晴れ',
      feeling: 'ちょうどいい',
      road_condition: '問題なし'
    )
    expect(post).to be_valid
  end

  describe '存在性の検証' do
    it '画像がないと投稿は無効であること' do
      post.image = ''
      post.valid?
      expect(post).to_not be_valid
    end
    it 'ユーザーが紐付いていないと投稿は無効であること' do
      post.user = nil
      post.valid?
      expect(post).to_not be_valid
    end
  end

  describe '文字数の検証' do
    it '説明が300文字以内の場合、有効であること' do
      post.description = 'a' * 300
      expect(post).to be_valid
    end
    it '投稿が300文字以上の場合、無効であること' do
      post.description = 'a' * 301
      expect(post).to_not be_valid
    end
  end

  describe 'メソッド' do
    it '投稿をいいね/いいね解除できること' do
      alice = create(:user)
      bob = create(:user, :with_posts)
      expect(bob.posts.first.liked_by?(alice)).to eq false
      alice.like(bob.posts.first)
      expect(bob.posts.first.liked_by?(alice)).to eq true
      alice.unlike(bob.posts.first)
      expect(bob.posts.first.liked_by?(alice)).to eq false
    end
  end

  describe 'その他' do
    it '記事を削除すると、関連するコメントも削除されること' do
      post = create(:post, :with_comments)
      expect { post.destroy }.to change { Comment.count }.by(-1)
    end

    it '記事を削除すると、関連するいいねも削除されること' do
      post = create(:post, :with_likes)
      expect { post.destroy }.to change { Post.count }.by(-1)
    end
  end
end
