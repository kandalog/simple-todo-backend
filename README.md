# シンプルタスク

## 使用技術

| カテゴリ             | 技術                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 言語                 | [![Ruby](https://img.shields.io/badge/Ruby-FF0000?style=for-the-badge&logo=ruby&logoColor=white)](https://www.ruby-lang.org/)                                                                                                                                                                                                                                                                                                                      |
| フレームワーク       | [![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)](https://rubyonrails.org/)                                                                                                                                                                                                                                                                                             |
| データベース         | [![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)                                                                                                                                                                                                                                                                                                                       |
| テストフレームワーク | [![RSpec](https://img.shields.io/badge/RSpec-CC0000?style=for-the-badge&logo=ruby&logoColor=white)](https://rspec.info/) [![FactoryBot](https://img.shields.io/badge/FactoryBot-6F42C1?style=for-the-badge&logo=ruby&logoColor=white)](https://github.com/thoughtbot/factory_bot)                                                                                                                                                                  |
| インフラ             | [![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/) [![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)](https://github.com/features/actions) |

## 概要

タスク管理アプリ

## 公開 URL

未公開

## Getting Started(local)

**起動**

```
$ git clone <repository>
$ cp .env.sample docker/.env
$ docker compose up -d
$ docker compose exec app rails db:setup
```

**起動確認**

```
$ curl localhost:4000
```

## テスト実行方法

```
$ docker compose run --rm app rspec
```

## フォーマッター実行方法

```
$ docker compose run --rm app rubocop -a
```
