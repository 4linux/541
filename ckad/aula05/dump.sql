USE php;

DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nome VARCHAR(50),
        email VARCHAR(100),
        senha CHAR(60),
        cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO usuarios (nome, email, senha) VALUES ('Suporte DevOps', 'suporte@4labs.example', '$2y$10$qTdhcJ8CkKztrvRhBN7EG.UB/YqfwjXpV2iKrZjvTIp2HTzqcflvi');
INSERT INTO usuarios (nome, email, senha) VALUES ('Developer PHP', 'developer@4labs.example', '$2y$10$mKvUbxiLFx9V4WPcNT3dWehd9xJ5xyZi2wkmadK8UlJBnYrLpwAqi');
