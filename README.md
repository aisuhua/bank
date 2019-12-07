# Bank

[Live Demo](http://122.51.144.50:81) 2019-12-07 日后可访问

## 项目依赖

- PHP 7.0+
- Phalcon Framework 3.4+
- MySQL 5.6+
- Nginx

## 安装

PHP 环境安装参考：https://github.com/aisuhua/wiki/tree/master/php

## 初始化

设置目录可写

```
chmod -R u+w app/cache/metadata app/cache/volt app/log
```

添加 Nginx 配置

```
# resources/nginx/nginx.conf
server {
    listen        80;
    server_name   bank.demo.com;

    root /www/web/bank/public;
    index index.php index.html index.htm;

    charset utf-8;
    client_max_body_size 100M;
    fastcgi_read_timeout 1800;

    location / {
        try_files $uri $uri/ /index.php?_url=$uri&$args;
    }

    location ~ [^/]\.php(/|$) {
        fastcgi_pass  127.0.0.1:9000;

        fastcgi_index /index.php;

        include fastcgi_params;
        fastcgi_split_path_info ^(.+?\.php)(/.*)$;
        if (!-f $document_root$fastcgi_script_name) {
            return 404;
        }

        fastcgi_param PATH_INFO       $fastcgi_path_info;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

    location ~ /\.ht {
        deny all;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
        expires       max;
        log_not_found off;
        access_log    off;
    }
}

```

创建数据库，数据表结构在 resources/mysql/dbs.sql
