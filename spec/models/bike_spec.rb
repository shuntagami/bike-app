require 'rails_helper'

RSpec.describe Bike, type: :model do
  before do
    @user = create(:user)
    @bike = @user.build_bike(
      bike_name: "cb400",
      cc_id: 1,
      maker_id: 1,
      type_id: 1
    )
  end
  it '有効なファクトリを持つこと' do
    expect(@bike).to be_valid
  end
end
