-- 1.
call sp_InserirFuncionario('03324359211', 'Patricia', '29', '06', '1999');

call sp_InserirProjeto('1','Projeto Han','S','1');

select * from funcionario;

-- 2.
select * from projeto;
select * from departamento;

insert into departamento
	values (1, 'DAIC');
insert into projeto
	values (1, 'APBD', 'S', 1);
    
call sp_ListarDepartamento(1);

-- 3.
select * from funcionario;

call sp_AtualizarFuncionario('03324359211', 'Patricia');

-- 4.
select * from TrabalhaEm;
insert into TrabalhaEm
	values(12, '03324359211','1');

call sp_RetornarFuncionarios();

-- 5.
call sp_RetornarAniversario('06');

-- 6.
select * from projeto;
call sp_ExcluirProjeto(1);

-- 7.
call sp_RetornarDataNasc('03324359211');

-- 8.
call sp_RetornarFuncProj();

-- 9.
call sp_RetornarProjeto('p');