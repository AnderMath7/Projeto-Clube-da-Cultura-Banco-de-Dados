/*
Matheus Anderson de Sousa Gomes – UC22103034 – Ciência da Computação 
Rafael Alves de Araujo – UC22200074 – Ciência da Computação 
Scarllet Gomes Rodrigues – UC11029899 – Ciência da Computação 
*/

CREATE DATABASE IF NOT EXISTS cultura;
USE cultura;

CREATE TABLE IF NOT EXISTS usuarios(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome TINYTEXT NOT NULL,
    senha CHAR(8) NOT NULL,
    email TINYTEXT NOT NULL,
    data_nascimento DATE,
    foto LONGBLOB
);

CREATE TABLE IF NOT EXISTS obras(
	id INT PRIMARY KEY AUTO_INCREMENT,
    titulo TINYTEXT NOT NULL,
    descricao TEXT NOT NULL,
    capa LONGBLOB,
    duracao TIME
);

CREATE TABLE IF NOT EXISTS anotacoes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    resenha LONGTEXT NOT NULL,
    titulo TINYTEXT NOT NULL,
    data_anotacao DATE,
    nota TINYINT NOT NULL,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    id_obra INT,
    FOREIGN KEY (id_obra) REFERENCES obras(id)
);

CREATE TABLE IF NOT EXISTS grupos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(35) NOT NULL,
    descicao TINYTEXT,
    dataCriacao DATE,
    id_usuario INT, -- Usuário criador
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS usuariosGrupos(
	id_usuarioGrupos INT PRIMARY KEY AUTO_INCREMENT,
	id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    id_grupo INT,
    FOREIGN KEY (id_grupo) REFERENCES grupos(id)
);

CREATE TABLE IF NOT EXISTS livros(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    editora VARCHAR(50),
    paginas INT,
    tipo TINYTEXT NOT NULL,
    sinopse TEXT NOT NULL,
    capa LONGBLOB,
    autor TINYTEXT NOT NULL,
    genero VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS capitulos(
	id INT PRIMARY KEY AUTO_INCREMENT,
    capitulo INT,
    paginas INT NOT NULL,
    id_livro INT,
    FOREIGN KEY (id_livro) REFERENCES livros(id),
    id_obra INT,
    FOREIGN KEY (id_obra) REFERENCES obras(id)
);

CREATE TABLE IF NOT EXISTS series(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    sinopse TEXT NOT NULL,
    capa LONGBLOB,
    genero VARCHAR(20) NOT NULL,
    temporadas INT,
    diretor TINYTEXT
);

CREATE TABLE IF NOT EXISTS episodios(
	id INT PRIMARY KEY AUTO_INCREMENT,
    episodio INT NOT NULL,
    temporada INT NOT NULL,
    id_serie INT,
    FOREIGN KEY (id_serie) REFERENCES series(id),
    id_obra INT,
    FOREIGN KEY (id_obra) REFERENCES obras(id)
);

CREATE TABLE IF NOT EXISTS filmes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    plataforma VARCHAR(20),
    diretor TINYTEXT,
    ator TINYTEXT,
    genero VARCHAR(20) NOT NULL,
    id_obra INT,
    FOREIGN KEY (id_obra) REFERENCES obras(id)
);

CREATE TABLE IF NOT EXISTS metas(
	id INT PRIMARY KEY AUTO_INCREMENT,
	prazo DATE,
    progresso INT NOT NULL,
    data_reuniao DATE,
    localReuniao TINYTEXT NOT NULL,
    id_usuarioGrupo INT,
    FOREIGN KEY (id_usuarioGrupo) REFERENCES usuariosGrupos(id_usuarioGrupos),
    id_capitulo INT,
    FOREIGN KEY (id_capitulo) REFERENCES capitulos(id),
    id_episodio INT,
    FOREIGN KEY (id_episodio) REFERENCES episodios(id),
    id_filme INT,
    FOREIGN KEY (id_filme) REFERENCES filmes(id)
);

INSERT INTO usuarios (nome, senha, email, data_nascimento, foto) VALUES
('Ana Martins', 'abcd1234', 'ana.martins@example.com', '1990-01-01', NULL),
('Bruno Ferreira', 'efgh5678', 'bruno.ferreira@example.com', '1985-02-02', NULL),
('Carla Pereira', 'ijkl9012', 'carla.pereira@example.com', '1992-03-03', NULL),
('Daniela Costa', 'mnop3456', 'daniela.costa@example.com', '1995-04-04', NULL),
('Eduardo Lima', 'qrst7890', 'eduardo.lima@example.com', '1988-05-05', NULL);

INSERT INTO obras (titulo, descricao, capa, duracao) VALUES
-- Livro
('No Verão', 'Conhecemos Nick Carraway ao se mudar para West Egg e descrever seu vizinho misterioso, Jay Gatsby', NULL, '00:10:00'),
('Capítulo 1', 'Conhecemos Winston Smith em um mundo distópico controlado por um regime totalitário, onde ele começa a questionar a autoridade opressiva do Partido.', NULL, '00:15:00'),
('Os Animais da Granja do Solar', 'Conhecemos os animais da Granja do Solar, que estão insatisfeitos com a liderança humana e expressam esperança por um futuro melhor.', NULL, '00:13:00'),
('Que trata da condição e exercício do famoso fidalgo Dom Quixote de la Mancha', 'Conhecemos Alonso Quijano, um fidalgo que, influenciado por histórias de cavalaria, decide se transformar no cavaleiro andante Dom Quixote de la Mancha.', NULL, '00:20:00'),
('Primeira Parte: Capítulo 1', ' Tolstoy apresenta a alta sociedade russa do início do século XIX, preparando o cenário para a invasão napoleônica iminente.', NULL, '00:30:00'),
-- filmes
('A Montanha Mágica', 'Uma narrativa sobre a vida em um sanatório.', NULL, '03:00:00'),
('O Apanhador no Campo de Centeio', 'A história de um jovem desiludido.', NULL, '02:00:00'),
('Admirável Mundo Novo', 'Uma visão futurista de uma sociedade controlada.', NULL, '01:50:00'),
('Cem Anos de Solidão', 'A saga de uma família ao longo de gerações.', NULL, '02:45:00'),
('O Senhor dos Anéis', 'Uma aventura épica na Terra Média.', NULL, '03:30:00'),
-- series
('Episódio 1 - O Início', 'Primeiro episódio da série A Montanha Encantada.', NULL, '00:45:00'),
('Episódio 2 - O Despertar', 'Segundo episódio da série A Montanha Encantada.', NULL, '00:50:00'),
('Episódio 1 - O Enigma', 'Primeiro episódio da série O Vento do Norte.', NULL, '00:40:00'),
('Episódio 2 - A Jornada', 'Segundo episódio da série O Vento do Norte.', NULL, '00:42:00'),
('Episódio 1 - O Chamado', 'Primeiro episódio da série Lendas do Oeste.', NULL, '00:55:00');

INSERT INTO anotacoes (resenha, titulo, data_anotacao, nota, id_usuario, id_obra) VALUES
('Uma análise profunda de como Fitzgerald retrata o sonho americano em O Grande Gatsby.', 'Crítica de O Grande Gatsby', '2024-06-25', 5, 1, 1),
('Reflexões críticas sobre a vigilância totalitária em 1984.', 'Crítica de 1984', '2024-06-25', 4, 2, 2),
('Comentário crítico sobre a alegoria política de A Revolução dos Bichos.', 'Crítica de A Revolução dos Bichos', '2024-06-25', 4, 3, 3),
('Análise crítica das idealizações de Dom Quixote em contraste com a realidade.', 'Crítica de Dom Quixote', '2024-06-25', 5, 4, 4),
('Impressões críticas sobre a complexidade social em Guerra e Paz.', 'Crítica de Guerra e Paz', '2024-06-25', 4, 5, 5),
('Crítica detalhada sobre as nuances psicológicas em A Montanha Mágica.', 'Crítica de A Montanha Mágica', '2024-06-25', 4, 1, 6),
('Avaliação crítica das interpretações em O Apanhador no Campo de Centeio.', 'Crítica de O Apanhador no Campo de Centeio', '2024-06-25', 3, 2, 7),
('Análise crítica das implicações sociais em Admirável Mundo Novo.', 'Crítica de Admirável Mundo Novo', '2024-06-25', 4, 3, 8),
('Resenha crítica sobre a construção narrativa de Cem Anos de Solidão.', 'Crítica de Cem Anos de Solidão', '2024-06-25', 5, 4, 9),
('Comentário crítico sobre a adaptação cinematográfica de O Senhor dos Anéis.', 'Crítica de O Senhor dos Anéis', '2024-06-25', 5, 5, 10),
('Primeiras impressões críticas sobre o episódio piloto de A Montanha Encantada.', 'Crítica de A Montanha Encantada - Episódio 1', '2024-06-25', 4, 1, 11),
('Reflexões críticas sobre o desenvolvimento de personagens em O Vento do Norte.', 'Crítica de O Vento do Norte - Episódio 2', '2024-06-25', 4, 4, 14),
('Análise crítica do mistério apresentado em Lendas do Oeste - Episódio 1.', 'Crítica de Lendas do Oeste - Episódio 1', '2024-06-25', 5, 5, 15);


INSERT INTO grupos (nome, descicao, dataCriacao, id_usuario) VALUES
('Clube do Livro', 'Grupo de discussão sobre livros', '2024-01-01', 1),
('Cine Clube', 'Grupo de discussão sobre filmes', '2024-02-02', 2),
('Séries e TV', 'Grupo de discussão sobre séries', '2024-03-03', 3),
('Anime Club', 'Grupo de discussão sobre animes', '2024-04-04', 4),
('Club de Mangá', 'Grupo de discussão sobre mangás', '2024-05-05', 5);

INSERT INTO usuariosGrupos (id_usuario, id_grupo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


INSERT INTO livros (nome, editora, paginas, tipo, sinopse, capa, autor, genero) VALUES
('O Grande Gatsby', 'Charles Scribner', 218, 'fisico', 'Uma história sobre o sonho americano.', NULL, 'F. Scott Fitzgerald', 'Ficção'),
('1984', 'Secker & Warburg', 328, 'fisico', 'Um retrato distópico do futuro.', NULL, 'George Orwell', 'Ficção científica'),
('A Revolução dos Bichos', 'Secker & Warburg', 112, 'digital', 'Uma sátira política sobre a sociedade.', NULL, 'George Orwell', 'Ficção'),
('Dom Quixote', 'Francisco de Robles', 992, 'digital', 'As aventuras do cavaleiro da triste figura.', NULL, 'Miguel de Cervantes', 'Ficção'),
('Guerra e Paz', 'The Russian Messenger', 1225, 'fisico', 'Uma crônica da sociedade russa.', NULL, 'Leo Tolstoy', 'Ficção histórica');

INSERT INTO capitulos (capitulo, paginas, id_livro, id_obra) VALUES
(1, 20, 1, 1),
(2, 25, 2, 2),
(1, 12, 3, 3),
(1, 30, 4, 4),
(1, 40, 5, 5);

INSERT INTO series (nome, sinopse, capa, genero, temporadas, diretor) VALUES
('A Montanha Encantada', 'Uma série sobre mistérios em uma montanha mágica.', NULL, 'Fantasia', 1, 'Jane Smith'),
('O Vento do Norte', 'Uma série de aventuras em terras geladas.', NULL, 'Aventura', 1, 'John Johnson'),
('Lendas do Oeste', 'Histórias épicas do Velho Oeste.', NULL, 'Histórico', 1, 'Robert Brown');

INSERT INTO episodios (episodio, temporada, id_serie, id_obra) VALUES
(1, 1, 1, 11),
(2, 1, 1, 12),
(1, 1, 2, 13),
(2, 1, 2, 14),
(1, 1, 3, 15);

INSERT INTO filmes (plataforma, diretor, ator, genero, id_obra) VALUES
('Netflix', 'Volker Schlöndorff', 'John Doe', 'Drama', 6),
('Amazon Prime', 'Steven Soderbergh', 'Jane Doe', 'Drama', 7),
('Hulu', 'Ridley Scott', 'Tom Hardy', 'Ficção Científica', 8),
('Disney+', 'Francis Ford Coppola', 'Marlon Brando', 'Drama', 9),
('HBO Max', 'Peter Jackson', 'Elijah Wood', 'Fantasia', 10);

INSERT INTO metas (prazo, progresso, data_reuniao, localReuniao, id_usuarioGrupo, id_capitulo, id_episodio, id_filme) VALUES
('2024-07-01', 20, '2024-06-10', 'Café Literário', 1, 1, NULL, NULL),
('2024-08-01', 30, '2024-06-11', 'Sala de Cinema', 2, 2, NULL, NULL),
('2024-09-01', 40, '2024-06-12', 'Auditório Central', 3, 3, NULL, NULL),
('2024-10-01', 50, '2024-06-13', 'Biblioteca Municipal', 4, 4, NULL, NULL),
('2024-11-01', 60, '2024-06-14', 'Teatro da Cidade', 5, 5, NULL, NULL),
('2024-12-01', 70, '2024-06-15', 'Café Literário', 1, NULL, 1, NULL),
('2025-01-01', 80, '2024-06-16', 'Sala de Cinema', 2, NULL, 2, NULL),
('2025-02-01', 90, '2024-06-17', 'Auditório Central', 3, NULL, 3, NULL),
('2025-03-01', 100, '2024-06-18', 'Biblioteca Municipal', 4, NULL, 4, NULL),
('2025-04-01', 100, '2024-06-19', 'Teatro da Cidade', 5, NULL, 5, NULL),
('2025-05-01', 100, '2024-06-20', 'Café Literário', 1, NULL, NULL, 1),
('2025-06-01', 100, '2024-06-21', 'Sala de Cinema', 2, NULL, NULL, 2),
('2025-07-01', 100, '2024-06-22', 'Auditório Central', 3, NULL, NULL, 3),
('2025-08-01', 100, '2024-06-23', 'Biblioteca Municipal', 4, NULL, NULL, 4),
('2025-09-01', 100, '2024-06-24', 'Teatro da Cidade', 5, NULL, NULL, 5);


-- TRAZER ANOTACOES DOS USUARIOS
SELECT usuarios.nome, anotacoes.titulo, anotacoes.resenha
FROM usuarios
INNER JOIN anotacoes ON usuarios.ID = anotacoes.ID_usuario;

-- Usuarios em cada grupo
SELECT usuarios.nome AS nome_usuario, grupos.nome AS nome_grupo 
FROM usuariosGrupos
JOIN usuarios ON usuarios.id = usuariosGrupos.id_usuario 
JOIN grupos ON grupos.id = usuariosGrupos.id_grupo;

-- TRAZER PROGRESSO DAS METAS DOS GRUPOS NOME DA META 
SELECT g.nome AS grupo, o.titulo AS nome_obra, m.progresso AS progesso_metas
FROM usuariosGrupos ug
JOIN grupos g ON g.id = ug.id_grupo
JOIN metas m ON ug.id_usuarioGrupos = m.id_usuarioGrupo
LEFT JOIN capitulos c ON c.id = m.id_capitulo
LEFT JOIN filmes f ON f.id = m.id_filme
LEFT JOIN episodios e ON e.id = m.id_episodio
LEFT JOIN obras o ON (o.id = c.id_obra OR o.id = f.id_obra OR o.id = e.id_obra);


-- Trazer todas as metas finalizadas
SELECT g.nome AS grupo, o.titulo AS nome_obra, m.progresso AS progesso_metas
FROM usuariosGrupos ug
JOIN grupos g ON g.id = ug.id_grupo
JOIN metas m ON ug.id_usuarioGrupos = m.id_usuarioGrupo
LEFT JOIN capitulos c ON c.id = m.id_capitulo
LEFT JOIN filmes f ON f.id = m.id_filme
LEFT JOIN episodios e ON e.id = m.id_episodio
LEFT JOIN obras o ON (o.id = c.id_obra OR o.id = f.id_obra OR o.id = e.id_obra)
WHERE m.progresso = 100;

-- trazer todas as metas inacabadas
SELECT g.nome AS grupo, o.titulo AS nome_obra, m.progresso AS progesso_metas
FROM usuariosGrupos ug
JOIN grupos g ON g.id = ug.id_grupo
JOIN metas m ON ug.id_usuarioGrupos = m.id_usuarioGrupo
LEFT JOIN capitulos c ON c.id = m.id_capitulo
LEFT JOIN filmes f ON f.id = m.id_filme
LEFT JOIN episodios e ON e.id = m.id_episodio
LEFT JOIN obras o ON (o.id = c.id_obra OR o.id = f.id_obra OR o.id = e.id_obra)
WHERE m.progresso < 100;

-- TODAS AS INFOS DE UMA OBRA 
SELECT o.id, o.titulo, o.descricao, o.capa, o.duracao, l.nome AS livro, l.editora, l.paginas, l.tipo, l.sinopse,
    l.capa AS capa_livro, l.autor, l.genero, s.nome AS serie, s.sinopse AS sinopse_serie, s.capa AS capa_serie,
    s.genero AS genero_serie, s.temporadas, s.diretor AS diretor_serie, f.plataforma, f.diretor AS diretor_filme,
    f.ator, f.genero AS genero_filme
FROM  obras o
LEFT JOIN capitulos c ON o.id = c.id_obra
LEFT JOIN livros l ON c.id_livro = l.id
LEFT JOIN episodios e ON o.id = e.id_obra
LEFT JOIN series s ON e.id_serie = s.id
LEFT JOIN filmes f ON o.id = f.id_obra;

 -- TRAZER TODAS AS IFORMAÇOES DAS OBRAS QUE OS USUARIOS ESTAO RELACIONADOS
 SELECT 
u.nome AS usuario, g.nome AS grupo, o.id AS obra_id, o.titulo AS obra_titulo, o.descricao AS obra_descricao,
    o.capa AS obra_capa, o.duracao AS obra_duracao, l.id AS livro_id, l.nome AS livro_nome, l.editora AS livro_editora,
    l.paginas AS livro_paginas, l.tipo AS livro_tipo, l.sinopse AS livro_sinopse, l.capa AS livro_capa,
    l.autor AS livro_autor, l.genero AS livro_genero, s.id AS serie_id, s.nome AS serie_nome, s.sinopse AS serie_sinopse,
    s.capa AS serie_capa, s.genero AS serie_genero, s.temporadas AS serie_temporadas, s.diretor AS serie_diretor,
    f.id AS filme_id, f.plataforma AS filme_plataforma, f.diretor AS filme_diretor, f.ator AS filme_ator,
    f.genero AS filme_genero
FROM usuarios u
JOIN usuariosGrupos ug ON u.id = ug.id_usuario
JOIN grupos g ON ug.id_grupo = g.id
JOIN metas m ON ug.id_usuarioGrupos = m.id_usuarioGrupo
LEFT JOIN capitulos c ON c.id = m.id_capitulo
LEFT JOIN filmes f ON f.id = m.id_filme
LEFT JOIN episodios e ON e.id = m.id_episodio
LEFT JOIN obras o ON (o.id = c.id_obra OR o.id = f.id_obra OR o.id = e.id_obra)
LEFT JOIN livros l ON l.id = c.id_livro
LEFT JOIN series s ON s.id = e.id_serie
ORDER BY u.nome, o.titulo;

-- Lista de grupo e usuários que os criaram
SELECT g.nome, u.nome
FROM grupos g
JOIN usuarios u ON u.id = g.id_usuario;

-- Trazer obras que o grupo tem cadastrada
SELECT g.nome AS grupo, o.titulo AS obra, o.descricao, o.capa, o.duracao
FROM grupos g
JOIN usuariosGrupos ug ON g.id = ug.id_grupo
JOIN metas m ON ug.id_usuarioGrupos = m.id_usuarioGrupo
LEFT JOIN capitulos c ON c.id = m.id_capitulo
LEFT JOIN filmes f ON f.id = m.id_filme
LEFT JOIN episodios e ON e.id = m.id_episodio
LEFT JOIN obras o ON (o.id = c.id_obra OR o.id = f.id_obra OR o.id = e.id_obra)
ORDER BY (g.nome);
    
    
-- Todas as anotações sobre uma obras específica
SELECT u.nome AS usuario, g.nome AS grupo, a.titulo AS anotacao_titulo, a.resenha AS anotacao_resenha,
a.data_anotacao, a.nota AS anotacao_nota, o.titulo AS obra_titulo, l.nome AS livro_nome, s.nome AS serie_nome
FROM anotacoes a
JOIN obras o ON a.id_obra = o.id
JOIN usuarios u ON u.id = a.id_usuario
LEFT JOIN usuariosGrupos ug ON ug.id_usuario = u.id
LEFT JOIN grupos g ON g.id = ug.id_grupo
LEFT JOIN capitulos c ON c.id_obra = o.id
LEFT JOIN livros l ON l.id = c.id_livro
LEFT JOIN filmes f ON f.id_obra = o.id
LEFT JOIN episodios e ON e.id_obra = o.id
LEFT JOIN series s ON s.id = e.id_serie
ORDER BY u.nome, o.titulo;

-- Metas que possuem mais de 30 min de duração
SELECT o.titulo AS nome_obra, o.duracao AS duracao, g.nome AS grupo, m.progresso AS progresso_metas
FROM usuariosGrupos ug
JOIN grupos g ON g.id = ug.id_grupo
JOIN metas m ON ug.id_usuarioGrupos = m.id_usuarioGrupo
LEFT JOIN capitulos c ON c.id = m.id_capitulo
LEFT JOIN filmes f ON f.id = m.id_filme
LEFT JOIN episodios e ON e.id = m.id_episodio
LEFT JOIN obras o ON (o.id = c.id_obra OR o.id = f.id_obra OR o.id = e.id_obra)
WHERE m.progresso < 100 AND TIME_TO_SEC(o.duracao) > 1800;

-- Número de participantes em cada grupo
SELECT count(u.id), g.nome
FROM grupos g
JOIN usuariosGrupos ug ON ug.id_grupo = g.id
JOIN usuarios u ON u.id = ug.id_usuario
GROUP BY(g.nome);

-- Todos os grupos de um usuário ESPECÍFICO
SELECT u.nome AS usuário, g.nome AS grupo
FROM grupos g
JOIN usuariosGrupos ug ON ug.id_grupo = g.id
JOIN usuarios u ON u.id = ug.id_usuario
WHERE u.id = 1; -- Mude o id para diferentes usuários

-- Todas as obras de ficçao
SELECT o.titulo, o.descricao, l.nome AS livro, l.genero, s.nome AS serie,
s.genero AS genero_serie, f.genero AS genero_filme
FROM  obras o
LEFT JOIN capitulos c ON o.id = c.id_obra
LEFT JOIN livros l ON c.id_livro = l.id
LEFT JOIN episodios e ON o.id = e.id_obra
LEFT JOIN series s ON e.id_serie = s.id
LEFT JOIN filmes f ON o.id = f.id_obra
WHERE l.genero LIKE '%Ficção%' OR f.genero LIKE '%Ficção%' OR s.genero LIKE '%Ficção%';