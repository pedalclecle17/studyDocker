# docker-hubからOSのイメージ引込
FROM centos:latest

# サーバの日付合わせ
RUN /bin/cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# epel-releaseのインストール
RUN dnf install -y epel-release &&\
    dnf clean all

# remiのインストール
RUN rpm -ivh http://ftp.riken.jp/Linux/remi/enterprise/remi-release-8.rpm

# yumのアップデート
RUN dnf update -y &&\
    dnf clean all

# 必要なモジュールのインストール(apache）
RUN dnf -y install httpd &&\
    dnf clean all

# 必要なモジュールのインストール（php7.4）
RUN dnf -y install php74-php php74-php-mysqli php74-php-gd php74-php-mbstring php74-php-opcache php74-php-xml php74-php-pear php74-php-devel php74-php-pecl-imagick php74-php-pecl-imagick-devel php74-php-pecl-zip

# phpコマンドを作成
RUN ln /usr/bin/php74 /usr/bin/php

# wordpressインストールディレクトリの所有者をapacheユーザに変更                                              
RUN chown -R apache:apache /var/www/html

# php74-php-fpmのサービス永続化
RUN systemctl enable php74-php-fpm

# apache サーバのサービス永続化
RUN systemctl enable httpd 

# 接続用ポートの穴あけ
EXPOSE 80 443

