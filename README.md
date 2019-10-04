開発用docker-compose
====================

# 概要


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





