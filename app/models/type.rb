class Type < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: 'ネイキッド' },
    { id: 2, name: 'クラシック' },
    { id: 3, name: 'ストリートファイター' },
    { id: 4, name: 'スーパースポーツ' },
    { id: 5, name: 'ツアラー' },
    { id: 6, name: 'アメリカン' },
    { id: 7, name: 'オフロード' },
    { id: 8,  name: 'その他' },
  ]
end
