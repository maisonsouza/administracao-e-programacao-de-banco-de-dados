-- 1. Inserir dados para um novo funcionário
USE `empresa`;
DROP procedure IF EXISTS `sp_InserirFuncionario`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE sp_InserirFuncionario (IN cpf char(11), 
										IN nome varchar(50),
                                        IN diaNasc char(2),
                                        IN mesNasc char(2),
                                        IN anoNasc char(4))
BEGIN
	insert into funcionario
		values (cpf, nome, diaNasc, mesNasc, anoNasc);
END$$

DELIMITER ; 

-- 2. Listar o código e o nome do departamento conforme o código do projeto informado
USE `empresa`;
DROP procedure IF EXISTS `sp_ListarDepartamento`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE sp_ListarDepartamento (IN spcodigo int)
BEGIN
	select departamento.codigo, departamento.nome 
		from departamento
        inner join projeto on departamento.codigo = dCodigo
        where spcodigo = projeto.codigo;
END$$

DELIMITER ;



-- 3. Atualizar o nome de um determinado funcionário conforme o seu CPF informado
USE `empresa`;
DROP procedure IF EXISTS `sp_AtualizarFuncionario`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE sp_AtualizarFuncionario (IN spcpf char(11), IN spnome varchar(50))
BEGIN
	update funcionario
		set nome = spnome
        where cpf = spcpf;
END$$

DELIMITER ;


/* 4. Retornar o nome de todos os funcionários e total de horas(somar todas as horas em todos os
 projetos) trabalhadas em projetos ativos */
USE `empresa`;
DROP procedure IF EXISTS `sp_RetornarFuncionarios`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE sp_RetornarFuncionarios ()
BEGIN
	select funcionario.nome, sum(horas) 
		from funcionario
        inner join TrabalhaEm on funcionario.cpf = fCpf
        group by funcionario.nome;
END$$

DELIMITER ;

-- 5. Criar uma lista dos funcionários, contendo nome e dia, quando informado o mês
USE `empresa`;
DROP procedure IF EXISTS `sp_RetornarAniversario`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE sp_RetornarAniversario (IN spMesNasc char(2))
BEGIN
	select nome, diaNasc
		from funcionario
        where mesNasc = spMesNasc;
END$$

DELIMITER ;

/* 6.  Excluir um determinado projeto conforme o seu código informado. Assuma que este tipo de ação 
faz com que automaticamente sejam exclusos quaisquer vínculos entre funcionário e projeto,ou seja, 
instâncias em TrabalhaEm sejam também automaticamente excluídas*/
USE `empresa`;
DROP procedure IF EXISTS `sp_ExcluirProjeto`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE sp_ExcluirProjeto (IN spCodigo int)
BEGIN
	delete from projeto
        where codigo = spCodigo;
	delete from TrabalhaEm
		where pCodigo = spCodigo;
END$$

DELIMITER ;

-- 7. Retornar a data de nascimento de um determinado funcionário quando informado seu CPF.
USE `empresa`;
DROP procedure IF EXISTS `sp_RetornarDataNasc`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE sp_RetornarDataNasc (IN spCpf char(11))
BEGIN
	select concat(diaNasc,'/',mesNasc,'/',anoNasc) 
		from funcionario
        where cpf = spCpf;
END$$

DELIMITER ;

-- 8. Criar uma lista contendo o nome dos funcionários e o nome dos projetos ativos dos quais estes participam.
USE `empresa`;
DROP procedure IF EXISTS `sp_RetornarFuncProj`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE sp_RetornarFuncProj ()
BEGIN
	select funcionario.nome, projeto.nome
		from funcionario
        inner join TrabalhaEm on funcionario.cpf = fCpf
        inner join Projeto on pCodigo = projeto.codigo
        where ativo = 'S';
END$$

DELIMITER ;

-- 9. Retornar o código e o nome completo do projeto ativo quando for informado apenas parte do nome deste projeto
USE `empresa`;
DROP procedure IF EXISTS `sp_RetornarProjeto`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE sp_RetornarProjeto (IN spNome varchar(100))
BEGIN
	select codigo, nome 
		from projeto
        where nome like concat('%',spNome,'%');
END$$

DELIMITER ;

-- Continuação Inserts 
USE `empresa`;
DROP procedure IF EXISTS `sp_InserirDepartamento`;

DELIMITER $$
USE `empresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InserirDepartamento`(IN codigo int(11), 
										IN nome varchar(50))
                                       
BEGIN
	insert into departamento
		values (codigo, nome);
END$$

DELIMITER ;

-- Inserir Projeto
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InserirFuncionario`(IN cpf char(11), 
										IN nome varchar(50),
                                        IN diaNasc char(2),
                                        IN mesNasc char(2),
                                        IN anoNasc char(4))
BEGIN
	insert into funcionario
		values (cpf, nome, diaNasc, mesNasc, anoNasc);
END

USE `empresa`;
DROP procedure IF EXISTS `sp_InserirProjeto`;

DELIMITER $$
USE `empresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InserirProjeto`(IN codigo int(11), 
										IN nome varchar(100),
                                        IN ativo char(1),
                                        
                                        IN dCodigo int(11))
BEGIN
	insert into projeto
		values (codigo, nome, ativo, dCodigo);
END$$

DELIMITER ;

-- Inserir TrabalhaEm
USE `empresa`;
DROP procedure IF EXISTS `sp_InserirTrabalhaEm`;

DELIMITER $$
USE `empresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InserirTrabalhaEm`(IN horas smallint(6), 
										IN fCpf char(11),
                                        IN pCodigo int (11))
BEGIN
	insert into trabalhaem
		values (horas, fCpf, pCodigo);
END$$

DELIMITER ;
