-- 1. Inserir dados para um novo aluno

USE `frequencia`;
DROP procedure IF EXISTS `sp_InserirAluno`;
DELIMITER $$
USE `frequencia`$$
CREATE PROCEDURE sp_InserirAluno (IN cpf char(11), 
										IN nome varchar(80),
                                        IN dataNasc varchar(10),
                                        IN email varchar (80),
                                        IN logradouro varchar (50),
                                        IN numero smallint,
                                        IN cep varchar(8),
                                        IN bairro varchar(20),
                                        IN complemento varchar(80),
                                        IN codigo char(5),
                                        IN matricula smallint)
BEGIN
	insert into pessoa
		values (cpf, nome, dataNasc, email, logradouro, numero, cep, bairro, complemento);
    insert into aluno	
		values (cpf, codigo, matricula);
END$$

-- 2) Cadastrar curso

USE `frequencia`;
DROP procedure IF EXISTS `sp_InserirCurso`;
DELIMITER $$
USE `frequencia`$$
CREATE PROCEDURE sp_InserirCurso (IN codigo char(5),
								  IN nome varchar(50))
BEGIN
	insert into curso
		values (codigo, nome);
END$$

-- 3. Inserir dados para um novo professor

USE `frequencia`;
DROP procedure IF EXISTS `sp_InserirProfessor`;
DELIMITER $$
USE `frequencia`$$
CREATE PROCEDURE sp_InserirProfessor (IN cpf char(11), 
										IN nome varchar(80),
                                        IN dataNasc varchar(10),
                                        IN email varchar (80),
                                        IN logradouro varchar (50),
                                        IN numero smallint,
                                        IN cep varchar(8),
                                        IN bairro varchar(20),
                                        IN complemento varchar(80),
                                        IN matricula smallint)
BEGIN
	insert into pessoa
		values (cpf, nome, dataNasc, email, logradouro, numero, cep, bairro, complemento);
    insert into professor	
		values (cpf, matricula);
END$$

-- 4. Inserir disciplina

USE `frequencia`;
DROP procedure IF EXISTS `sp_InserirDisciplina`;
DELIMITER $$
USE `frequencia`$$
CREATE PROCEDURE sp_InserirDisciplina (IN codigo char(5),
									   IN nome varchar(50),
                                       IN cargahoraria smallint,
                                       IN descricao varchar(80))
BEGIN
	insert into disciplina
		values (codigo, nome, cargahoraria, descricao);
END$$

-- 5. Inserir disciplina ofertada

USE `frequencia`;
DROP procedure IF EXISTS `sp_InserirDisciplinaOfertada`;
DELIMITER $$
USE `frequencia`$$
CREATE PROCEDURE sp_InserirDisciplinaOfertada (IN codigo char(5),
											   IN nome varchar (80),
                                               IN ano char(4),
                                               IN semestre char(4),
                                               IN codigoDisciplina char(5))
BEGIN
	insert into disciplinaOfertada 
		values (codigo, nome, ano, semestre, codigoDisciplina);
END$$
