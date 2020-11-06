require 'rails_helper'

describe Post do
  before do
    @post = FactoryBot.build(:post)
    @post.image = fixture_file_upload('public/images/test_image.png')
  end
  it '有効なファクトリを持つこと' do
    expect(@post).to be_valid
  end
end
