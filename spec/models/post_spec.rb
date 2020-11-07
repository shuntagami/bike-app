require 'rails_helper'

describe Post do
  let(:post) { create(:post) }

  describe '存在性の検証' do
    context "投稿が有効である場合" do
      it "画像と説明があれば有効であること" do
        expect(post).to be_valid
      end
      it "画像のみあれば有効であること" do
        post.description = ''
        expect(post).to be_valid
      end
    end

    context "投稿が無効である場合" do
      it "画像がないと投稿は無効であること" do
        post.image = ''
        post.valid?
        expect(post).to_not be_valid
      end     
      it "ユーザーが紐付いていないと投稿は無効であること" do
        post.user = nil
        post.valid?
        expect(post).to_not be_valid
      end
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
end
