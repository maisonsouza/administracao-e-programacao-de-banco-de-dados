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
CREATE PROCEDURE sp_ListarDepartamento (IN spcodigo int)
BEGIN
	select departamento.codigo, departamento.nome 
		from departamento
        inner join projeto on departamento.codigo = dCodigo
        where spcodigo = projeto.codigo;
END 

-- 3. Atualizar o nome de um determinado funcionário conforme o seu CPF informado
CREATE PROCEDURE sp_AtualizarFuncionario (IN spcpf char(11), IN spnome varchar(50))
BEGIN
	update funcionario
		set nome = spnome
        where cpf = spcpf;
END 

/* 4. Retornar o nome de todos os funcionários e total de horas(somar todas as horas em todos os
 projetos) trabalhadas em projetos ativos */
CREATE PROCEDURE sp_RetornarFuncionarios ()
BEGIN
	select funcionario.nome, sum(horas) 
		from funcionario
        inner join TrabalhaEm on funcionario.cpf = fCpf
        group by funcionario.nome;
END 

-- 5. Criar uma lista dos funcionários, contendo nome e dia, quando informado o mês
CREATE PROCEDURE sp_RetornarAniversario (IN spMesNasc char(2))
BEGIN
	select nome, diaNasc
		from funcionario
        where mesNasc = spMesNasc;
END 

/* 6.  Excluir um determinado projeto conforme o seu código informado. Assuma que este tipo de ação 
faz com que automaticamente sejam exclusos quaisquer vínculos entre funcionário e projeto,ou seja, 
instâncias em TrabalhaEm sejam também automaticamente excluídas*/
CREATE PROCEDURE sp_ExcluirProjeto (IN spCodigo int)
BEGIN
	delete from projeto
        where codigo = spCodigo;
	delete from TrabalhaEm
		where pCodigo = spCodigo;
END

-- 7. Retornar a data de nascimento de um determinado funcionário quando informado seu CPF.
CREATE PROCEDURE sp_RetornarDataNasc (IN spCpf char(11))
BEGIN
	select concat(diaNasc,'/',mesNasc,'/',anoNasc) 
		from funcionario
        where cpf = spCpf;
END 

-- 8. Criar uma lista contendo o nome dos funcionários e o nome dos projetos ativos dos quais estes participam.
CREATE PROCEDURE sp_RetornarFuncProj ()
BEGIN
	select funcionario.nome, projeto.nome
		from funcionario
        inner join TrabalhaEm on funcionario.cpf = fCpf
        inner join Projeto on pCodigo = projeto.codigo
        where ativo = 'S';
END 

-- 9. Retornar o código e o nome completo do projeto ativo quando for informado apenas parte do nome deste projeto
CREATE PROCEDURE sp_RetornarProjeto (IN spNome varchar(100))
BEGIN
	select codigo, nome 
		from projeto
        where nome like concat('%',spNome,'%');
END 