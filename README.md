# アプリ概要

[GoToTouring](http://touringtaro.work/)<br>

ライダーのための、ツーリングの機会損失を減らすことを目的としたアプリケーションです。<br>
具体的な状況としては「ツーリングに行ったはいいものの、路面が凍っていて引き返すことになった」、「夏だからと油断したら寒すぎて引き返すことになった」というようなことを防ぐために他のユーザーの投稿を見て事前に防ぐことができます。また、「自分のバイクを自慢したい」といった多くのライダーのニーズを満たすことや、や都道府県ごとの投稿検索機能を使って新たなツーリングスポットするといった使い方をすることもできます。


## トップページ
![sample](https://user-images.githubusercontent.com/69618840/102978259-96cddb00-4547-11eb-81be-7839e4939fc1.jpeg)


# 使用技術・言語

- フロントエンド(javascript, HTML/CSS, Sass, Bootstrap)
- バックエンド(Ruby2.6.5, Ruby on Rails6.0)
- テスト(RSpec, FactoryBot, Capybara)
- Webサーバ(nginx)
- applicationサーバ(puma)
- データベース(MySQL)
- コンテナ(Docker, docker-compose)
- AWS(VPC, EC2, Route53, ELB, ACM, ECS, ECR, SSM, KMS, S3, CloudWatch, CLI)
- インフラコード管理(terraform)
- 開発環境(MacOS, VScode, vim, Git, GitHub, CircleCI, zsh)

# インフラ構成
![environment](./public/images/bike_app_Env.png)

# 機能要件

### ユーザ機能

- ユーザ情報 登録・編集・削除
- ユーザ認証機能(Devise)
- テストユーザログイン機能
- 管理ユーザ機能
- フォロー、フォロワー機能(ajax)

### ツーリングスポット投稿機能

- 新規投稿、編集、削除
- いいね機能(ajax)
- コメント機能(ajax)

### 検索機能

- 都道府県、市区町村、キーワードから検索

### UI

- グローバルメニュー(ハンバーガーメニュー)
- グローバルサーチ
- ページネーション(kaminari) (トップページ)

# 非機能要件

- レスポンシブ対応
- エラーハンドリング
- HTTPS 接続
- データベースの定期バックアップ(bash + S3)
- モデル/コントローラの単体テスト
- 統合テスト






































