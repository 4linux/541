# PHP

Esta pequena aplicação faz parte de um dos exercícios do curso de Openshift da 4Linux.

## Objetivo

O objetivo é provisionar uma aplicação que suporte alta disponibilidade com os seguintes componentes:

- PHP
  - DeploymentConfig
  - Service
  - Route
  - ConfigMap
- Memcached
  - DeploymentConfig
  - Service
- MySQL
  - DeploymentConfig
  - Service
  - Secret

Lembre-se que um **DeploymentConfig** provisiona outros componentes e portanto estes não foram mencionados.

## Exigências

1. A aplicação **PHP** deve possuir **3** réplicas, e um **ConfigMap** deve ser montado em `/app/php-ini/php.ini`.
2. Dois **memcached** devem ser criados, porém cada qual com suas próprias configurações, serviços e pods - *não utilizar réplicas*.
3. O banco de dados deve utilizar um volume persistente, utilizando **NFS**.

**Dicas:**

- Não será possível utilizar a imagem **PHP** do catálogo do Openshift pois não há suporte para **memcached**.
- Uma imagem com todas as dependências pode ser gerada utilizando o `Dockerfile` presente no diretório `docker` deste repositório.
- O comando `oc new-app` pode ser utilizado, mas será preciso alterar o diretório em que o Openshift procura o `Dockerfile`.

## Aplicação - php

Esta aplicação utiliza 6 variáveis de ambiente, uma para o `php.ini` e as outras para se conectar ao banco de dados:

 - PHP_INI
 - DB_HOST
 - DB_PORT
 - DB_USER
 - DB_NAME
 - DB_PASS

O PHP utiliza o *php.ini* para configurar o servidor externo de cache, como por exemplo o **memcached**. Neste caso, dentro do *php.ini* adicionar:

```ini
[Session]
session.save_handler = memcached
session.save_path = "m1:11211,m2:11211,m3:11211...m9:11211"
```

## ConfigMap - php.ini

```
[PHP]
engine = On
short_open_tag = Off
precision = 14
output_buffering = 4096
zlib.output_compression = Off
implicit_flush = Off
unserialize_callback_func =
serialize_precision = -1
disable_functions =
disable_classes =
zend.enable_gc = On
expose_php = On
max_execution_time = 30
max_input_time = 60
memory_limit = 128M
error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
display_errors = Off
display_startup_errors = Off
log_errors = On
log_errors_max_len = 1024
ignore_repeated_errors = Off
ignore_repeated_source = Off
report_memleaks = On
html_errors = On
variables_order = "GPCS"
request_order = "GP"
register_argc_argv = Off
auto_globals_jit = On
post_max_size = 8M
auto_prepend_file =
auto_append_file =
default_mimetype = "text/html"
default_charset = "UTF-8"
include_path = ".:/usr/share/php7"
doc_root =
user_dir =
enable_dl = Off
file_uploads = On
upload_max_filesize = 2M
max_file_uploads = 20
allow_url_fopen = On
allow_url_include = Off
default_socket_timeout = 60

[CLI Server]
cli_server.color = On

[MySQLi]
mysqli.max_persistent = -1
mysqli.allow_persistent = On
mysqli.max_links = -1
mysqli.cache_size = 2000
mysqli.default_port = 3306
mysqli.default_socket =
mysqli.default_host =
mysqli.default_user =
mysqli.default_pw =
mysqli.reconnect = Off

[mysqlnd]
mysqlnd.collect_statistics = On
mysqlnd.collect_memory_statistics = Off

[bcmath]
bcmath.scale = 0

[Session]
session.save_handler = memcached
session.save_path = "<servico>:<porta>,<servico>:<porta>"
session.use_strict_mode = 0
session.use_cookies = 1
session.use_only_cookies = 1
session.name = PHPSESSID
session.auto_start = 0
session.cookie_lifetime = 0
session.cookie_path = /
session.cookie_domain =
session.cookie_httponly =
session.serialize_handler = php
session.gc_probability = 1
session.gc_divisor = 1000
session.gc_maxlifetime = 1440
session.referer_check =
session.cache_limiter = nocache
session.cache_expire = 180
session.use_trans_sid = 0
session.sid_length = 26
session.trans_sid_tags = "a=href,area=href,frame=src,form="
session.sid_bits_per_character = 5
```

## Memcached

O memcached não decide para qual das réplicas disponíveis a gravação e/ou leitura será feita. Essa decisão é de responsabilidade do cliente, sendo assim é preciso haver dois memcacheds, cada qual com seu respectivo serviço.

O endereço e a porta do memcached - por padrão **11211** - devem ser adicionadas no `php.ini`.

## MySQL

O banco de dados deve utilizar um volume persistente com **NFS** - não é a melhor opção, mas é o que temos no cluster, e o seguinte **dump** deve ser recuperado:

```sql
-- version 0.1
-- mysql -h 127.0.0.1 -u 'user' -p'password' database < db.sql
-- docker exec -i conteineres_mysql_1 mysql -u php -p'4linux' php < db/dump.sql

DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nome VARCHAR(50),
        email VARCHAR(100),
        senha CHAR(60),
        cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO usuarios (nome, email, senha) VALUES ('Paramahansa Yogananda', 'paramahansa@yogananda.in', '$2y$10$qTdhcJ8CkKztrvRhBN7EG.UB/YqfwjXpV2iKrZjvTIp2HTzqcflvi');
INSERT INTO usuarios (nome, email, senha) VALUES ('Mary Shelley', 'victor@frankenstein.co.uk', '$2y$10$mKvUbxiLFx9V4WPcNT3dWehd9xJ5xyZi2wkmadK8UlJBnYrLpwAqi');
-- Ambas as senhas são um hash de 123
```

Existem várias formas de restaurar o dump, utilize a sua criatividade!

## Testando a Aplicação

Existem dois usuários para testar o login da aplicação:

- paramahansa@yogananda.in com senha **123**
- victor@frankenstein.co.uk com senha **123**
