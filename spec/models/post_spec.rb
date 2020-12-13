require 'rails_helper'

describe Post do
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
    it '都道府県がない場合、無効であること' do
      post.prefecture = nil
      post.valid?
      expect(post).to_not be_valid
    end
    it '市区町村がない場合、無効であること' do
      post.city = nil
      post.valid?
      expect(post).to_not be_valid
    end
    it '天気がない場合、無効であること' do
      post.weather = ''
      post.valid?
      expect(post).to_not be_valid
    end
    it '体感がない場合、無効であること' do
      post.feeling = ''
      post.valid?
      expect(post).to_not be_valid
    end
    it '路面状況がない場合、無効であること' do
      post.road_condition = ''
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

  describe '#search' do
    # 各テストの前にPostを作成
    before do
      user = create(:user)
      prefecture = create(:prefecture, name: '神奈川県')
      @city = create(:city, name: '横須賀市', prefecture: prefecture)
      @post = create(
        :post,
        user: user,
        description: '今日は快晴です。',
        prefecture: @city.prefecture,
        city: @city,
        weather: '晴れ',
        feeling: 'ちょうどいい',
        road_condition: '問題なし'
      )

      other_prefecture = create(:prefecture, name: '東京都')
      @other_city = create(:city, name: '渋谷区', prefecture: other_prefecture)
      @other_post = create(
        :post,
        user: user,
        description: '今日は曇りです。',
        prefecture: @other_city.prefecture,
        city: @other_city,
        weather: '曇り',
        feeling: '寒い',
        road_condition: '一部凍っている'
      )
    end

    context "description: '晴'で検索した場合、曖昧検索できているか" do
      it '@postを返すこと' do
        expect(Post.search(description: '晴')).to include(@post)
      end

      it '@other_postを返さないこと' do
        expect(Post.search(description: '晴')).to_not include(@other_post)
      end
    end

    context '都道府県で検索した場合、一致検索できているか' do
      it '@postを返すこと' do
        expect(Post.search(prefecture_id: @city.prefecture.id)).to include(@post)
      end

      it '@other_postを返さないこと' do
        expect(Post.search(prefecture_id: @city.prefecture.id)).to_not include(@other_post)
      end
    end

    context '都道府県、市区町村で検索した場合、一致検索できているか' do
      it '@postを返すこと' do
        expect(Post.search(prefecture_id: @city.prefecture.id, city_id: @city.id)).to include(@post)
      end

      it '@other_postを返さないこと' do
        expect(Post.search(prefecture_id: @city.prefecture.id, city_id: @city.id)).to_not include(@other_post)
      end
    end

    context "weather: '晴れ'で検索した場合、一致検索できているか" do
      it '@postを返すこと' do
        expect(Post.search(weather: '晴れ')).to include(@post)
      end

      it '@other_postを返さないこと' do
        expect(Post.search(weather: '晴れ')).to_not include(@other_post)
      end
    end

    context "description: '雪'で検索した場合" do
      it '0件であること' do
        expect(Post.search(description: '雪')).to be_empty
      end
    end

    context "weather: '雪'で検索した場合" do
      it '0件であること' do
        expect(Post.search(weather: '雪')).to be_empty
      end
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
