## 勤怠取得プログラム
月次の勤怠表作成時に勤怠チャンネルから自分の出退勤情報を辿るのが辛いため、自分の出勤退勤情報だけ取得するプログラムを作成  
※ 実行しすぎると一時的に使用できなくなるので注意

## 使用方法
* SlackのAPIキーを取得
https://api.slack.com/custom-integrations/legacy-tokens

* 環境変数にAPIキー設定
```
$ export SLACK_API_TOKEN=取得したキー
```

* 実行
```
$ git clone git@github.com:kimuray/kintai_getter.git
$ cd kintai_getter
$ bin/kintai_getter kimuray 2018-01-01 2018-01-31
```
