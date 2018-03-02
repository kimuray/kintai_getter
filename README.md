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
$ bin/kintai_getter kimuray 2018-02-01 2018-02-28
02月02日 【出勤】10:00-19:00
02月04日 退勤 10:00-19:30
02月05日 【出勤】10:00-19:00
02月05日 【退勤】10:00-19:00
02月06日 【出勤】10:00-19:00
02月06日 退勤10:00-19:00
02月07日 【出勤】10:00-19:00
```
