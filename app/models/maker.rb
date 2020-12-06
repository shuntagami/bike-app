class Maker < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'ホンダ' },
    { id: 2, name: 'ヤマハ' },
    { id: 3, name: 'カワサキ' },
    { id: 4, name: 'スズキ' },
    { id: 5, name: 'ハーレーダビッドソン' },
    { id: 6, name: 'BMW' },
    { id: 7,  name: 'KTM' },
    { id: 8,  name: 'その他' }
  ]
end
