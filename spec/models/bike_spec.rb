require 'rails_helper'

RSpec.describe Bike, type: :model do
  before do
    @user = create(:user)
    @bike = @user.build_bike(
      bike_name: 'cb400',
      cc_id: 1,
      maker_id: 1,
      type_id: 1
    )
  end

  describe '有効性の検証' do
    it 'バイク名、排気量、種類がある場合、有効であること' do
      expect(@bike).to be_valid
    end
    it 'バイク名がない場合、無効であること' do
      @bike.bike_name = ''
      @bike.valid?
      expect(@bike).to_not be_valid
    end

    it '排気量がない場合、無効であること' do
      @bike.cc_id = 0
      @bike.valid?
      expect(@bike).to_not be_valid
    end

    it 'メーカーがない場合、無効であること' do
      @bike.maker_id = 0
      @bike.valid?
      expect(@bike).to_not be_valid
    end

    it '種類がない場合、無効であること' do
      @bike.type_id = 0
      @bike.valid?
      expect(@bike).to_not be_valid
    end

    it 'ユーザーがない場合、無効であること' do
      @bike.user = nil
      @bike.valid?
      expect(@bike).to_not be_valid
    end
  end
end
