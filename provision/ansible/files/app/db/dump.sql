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
