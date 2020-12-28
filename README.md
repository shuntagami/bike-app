# アプリ概要

[GoToTouring](http://touringtaro.work/)<br>

ライダーのための、ツーリングの機会損失を減らすことを目的としたアプリケーションです。<br>
具体的な状況としては「ツーリングに行ったはいいものの、路面が凍っていて引き返すことになった」、「夏だからと油断したら寒すぎて引き返すことになった」というようなことを防ぐために他のユーザーの投稿を見て事前に防ぐことができます。また、「自分のバイクを自慢したい」といった多くのライダーのニーズを満たすことや、都道府県ごとの投稿検索機能を使って新たなツーリングスポットを発見するといった使い方をすることもできます。

![sample](https://user-images.githubusercontent.com/69618840/102978259-96cddb00-4547-11eb-81be-7839e4939fc1.jpeg)


# 使用技術・言語

- フロントエンド(javascript, HTML/CSS, Sass, Bootstrap)
- バックエンド(Ruby2.6.5, Ruby on Rails6.0)
- テスト(RSpec, FactoryBot, Capybara)
- Webサーバ(nginx)
- applicationサーバ(puma)
- データベース(MySQL5.7.3)
- コンテナ(Docker, docker-compose)
- AWS(VPC, EC2, Route53, ELB, ACM, ECS, ECR, RDS, SSM, KMS, S3, CloudWatchLogs, Kinesis Fire Hose, CLI)
- インフラコード管理(terraform0.14.3)
- 開発環境(MacOS, VScode, vim, Git, GitHub, CircleCI, zsh)

# インフラ構成
![sample](https://user-images.githubusercontent.com/69618840/103174607-e04f5a80-48a6-11eb-84a1-04f9412439fd.png)

# テーブル設計
![sample](https://user-images.githubusercontent.com/69618840/103175014-3bcf1780-48aa-11eb-832d-990c75a5f714.png)

# 機能要件

### ユーザ機能

- ユーザ情報 登録・編集・削除
- ユーザ認証機能(Devise)
- テストユーザログイン機能
- 管理ユーザ機能(メールアドレス: admin@example.com, パスワード: 12345678)
- フォロー、フォロワー機能(ajax)

### ツーリングスポット投稿機能

- 投稿一覧表示、投稿詳細表示、記事投稿、記事編集、記事削除機能
- 都道府県SelectBoxに対する市区町村SelectBoxをAjaxで動的に制御
- 人気投稿表示機能、フィード機能(自身の投稿とフォローしたユーザーの投稿を表示)
- いいね機能(ajax)
- コメント機能(ajax)
- プレビュー機能(ajax)

### 検索機能

- 都道府県、市区町村、キーワードから検索

### UI

- グローバルメニュー(ハンバーガーメニュー)
- グローバルサーチ
- ページネーション(kaminari)
- プレビュー機能(新規投稿、投稿編集、userのプロフィール画像の編集)

# 非機能要件

- レスポンシブ対応
- エラーハンドリング
- HTTPS 接続
- CI/CDパイプラインの構築
- モデル/コントローラの単体テスト
- 統合テスト


# 特に力を入れた点

## N+1問題の解消

開発初期からbulletというgemを用いてN+!問題を極力起こさないように気をつけていました。また、bulletでは検出できないN+1問題も発見して解消し、その方法をqitaの記事として残すことで同じ過ちを繰り返さないように工夫しました。<br>
<a href="https://qiita.com/shuntagami23/items/3379fe1c8cae34355904">countメソッドの落とし穴（クエリの大量発行に注意！）</a>

## テストコード

「リリースしたアプリケーションにバグが起こる」ということは、現場で開発する際には特に防ぐべきことだと考えたため、時間を割いて勉強しました。モデルとコントローラーのテスト、統合テストのそれぞれの目的を理解し、最終的には「テストが全て通れば大丈夫」と思えるコードを書けました。また、モデルの単体テストにおいて「アソシエーション先のデータを生成する」という局面でつまづいたため、アウトプットをすることで知識の定着を図りました。<br>
<a href="https://qiita.com/shuntagami23/items/90d291bce5dbb75b8018">RSpecとFactoryBotを使ったインスタンスの作成</a>

## 非同期通信

リロードしてページを読み込む箇所が多すぎるとユーザーにストレスをかけてしまうため、できる範囲で非同期通信を実装しました。XMLHttpRequest, Fetch APIといったAPIの概要、JSON形式でデータのやりとりを行うメリットを理解し、実装方法をアウトプットしました。<br>
<a href="https://qiita.com/shuntagami23/items/cdbe3185a6307db8ce62">XHRをFetch APIで置き換えてみた （後編）</a>

## 環境構築

現場で開発する際には「プロジェクトごとに別々のバージョンを共存させる」といったことがあると考えたため基本的なlinuxコマンドを学習し、バージョンマネージャーを使って使用する使用する言語をインストールするようにしました。そして、その方法をすぐに実践できるように文章として残しました。<br>

<a href="https://qiita.com/shuntagami23/items/14c026496c0f895daa55">Homebrew + rbenv + ruby-build の関係性（前編）</a><br>
<a href="https://qiita.com/shuntagami23/items/05a5eb6d00c710619072">Homebrew + rbenv + ruby-build の関係性（後編）</a><br>
<a href="https://qiita.com/shuntagami23/items/c359eecf193a97ac7d31">anyenvに移行しました！（anyenvでrbenvとnodenvを管理する）</a><br>

加えて、シェルとvimの環境については以下のリポジトリからクローンしてシェルスクリプトを実行するだけで構築できるようにしました。<br>
https://github.com/shuntagami/dotfiles

## 難しい技術へのチャレンジ
開発環境の差異を減らす目的でdockerを導入しました。その後、dockerを導入したメリットを生かすためにコンテナオーケストレーションサービス(ECS)の導入や、CircleCIによる自動テスト、自動デプロイにもチャレンジしました。特にdocker, AWSの学習は「システム全体の理解」に繋がることが非常に楽しかったこともあり、インフラをコード化するところまで実装できました。（以下のリポジトリです）<br>
https://github.com/shuntagami/Terraform_test


# 今後の課題

## ① セレクトボックスでツーリングスポットを検索するのは目当ての投稿に辿り着くのが難しいこと

> Googlemap APIを用い、地図から投稿を検索できるようにすることで、視覚的に投稿を見つけられるようにしたいと思っています。

## ② viewファイルの一部にロジックが書かれており、可読性が低くなっていること（フォローボタンのif文による条件分岐など）
> フォローボタンであれば、React等のライブラリを使ってコンポーネント化することによって条件分岐はJavascriptファイル側で書くことによって解決できると考えています。JavascriptおよびTypescript,Reactについては現在勉強中です。

## ③ デザインが垢抜けないこと
> 上述したReactと共にMaterial-UIを導入することでもう少し洗練されたデザインにできるとは思います。しかしながら、フレームワークやライブラリに頼るだけでなく、自分でデザインする能力があるに越したことはないので、HTML&CSS、基本的なデザインの勉強も時間を見つけて取り入れたいです。








































