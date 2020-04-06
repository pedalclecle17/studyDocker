# docker-hubからOSのイメージ引込
FROM centos:centos8.1.1911

# サーバの日付合わせ
RUN /bin/cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# epel-releaseのインストール
RUN yum install -y epel-release &&\
    yum clean all

# remiのインストール
RUN rpm -ivh http://ftp.riken.jp/Linux/remi/enterprise/remi-release-8.rpm

# yumのアップデート
RUN yum update -y &&\
    yum clean all

# 必要なモジュールのインストール(apache）
RUN yum -y install httpd &&\
    yum clean all

# 必要なモジュールのインストール（php7.4）
RUN yum -y install php74-php php74-php-mysqli php74-php-gd php74-php-mbstring php74-php-opcache php74-php-xml

# phpコマンドを作成
RUN ln /usr/bin/php74 /usr/bin/php

# wordpressインストールディレクトリの所有者をapacheユーザに変更                                              
RUN chown -R apache:apache /var/www/html

# ｐｈｐ７４−ｐｈｐ−ｆｐｍのサービス永続化
RUN systemctl enable php74-php-fpm

# apache サーバのサービス永続化
RUN systemctl enable httpd 

# 接続用ポートの穴あけ
EXPOSE 80

