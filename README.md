# flutter_sample

本リポジトリは flutter の学習用サンプルリポジトリです
devcontainer の設定をしていますので、VS Code と Docker、Git さえあれば各種開発用設定が行われた Flutter の開発環境が構築され、即時開発が可能です

## 内容

- [devcontainer](https://code.visualstudio.com/docs/remote/containers)
- lint
  - [hadolint](https://github.com/hadolint/hadolint)
- [GitHub Actions](https://github.co.jp/features/actions)

## 環境詳細

- Dart : 2.13.1
- Flutter : 2.2.1

### 事前準備

- Docker インストール
- VS Code インストール
- VS Code の拡張機能「Remote - Containers」インストール
  - https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
- 本リポジトリの clone

### 開発手順

1. VS Code 起動
2. 左下の緑色のアイコンクリック
3. 「Remote-Containersa: Reopen in Container」クリック
4. しばらく待つ
   - 初回の場合コンテナー image の取得や作成が行われる
5. 起動
6. `flutter create hoge`
7. `cd hoge`
8. `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0`
