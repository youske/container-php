開発用docker-compose
====================

# 概要
迅速にバックエンドを構築するためのdocker-compose
フロントエンドは別に想定されているのでシステム側で用意する


# はじめに




# 事前準備 

##
docker & docker-composeをホストマシンにて入れておく
windowsでは toolbox用のdocker-composeファイルを用意しているのでそちらから起動する


##
volumes の設定
docker-compose.yml 側の設定と合わせる
$HOME/volumes/**

### docker networkの設定
docker-composeが管理するコンテナ間で通信するための仮想ネットワークを作成しておく
別のdokcer-composeの管理するコンテナでも通信できるようにexternalとしておく
```
$ docker network create development

```



## 起動
特に起動する順番に依存しないので以下のように立ち上げ
```
docker-compose up -d 
```

個別に行う場合は各サービスごとに実施
```
docker-compose up -d <service>
```




# 削除
docker-compose downにてすべてのコンテナを停止させ
ローカルボーリュームを削除
Docker Networkを撤去
```
$ docker-compose down
$ rm -r ./volumes 
$ dockert network destroy development

```


