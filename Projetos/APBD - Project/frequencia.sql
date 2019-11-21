create database frequencia;
-- drop database frequencia;
use frequencia;

create table pessoa(
cpf char(11) not null,
nome varchar(80) not null,
dataNasc varchar(10),
email varchar(80),
logradouro varchar(50),
numero smallint,
cep varchar(8),
bairro varchar(20),
complemento varchar(80),
primary key(cpf)
);

create table professor(
cpf char(11) not null,
matricula smallint unsigned not null,
primary key(cpf),
constraint fk_professor_pessoa foreign key(cpf) references pessoa(cpf)  
);

create table curso(
codigo char(5) not null,
nome varchar(50) not null,
primary key(codigo)
);

create table disciplina(
codigo char(5) not null,
nome varchar(50) not null,
cargaHoraria smallint,	
descricao varchar(80),
primary key (codigo) 
);

create table aluno(
cpf char(11) not null,
codigo char(5), 
matricula smallint unsigned not null,
primary key(cpf),
constraint fk_aluno_pessoa foreign key(cpf) references pessoa (cpf),
constraint fk_aluno_curso foreign key(codigo) references curso(codigo)
);

create table disciplinaOfertada(
codigo char(5) not null, 
nome varchar(80) not null,
ano char(4) not null, 
semestre char(1) not null,
codigoDisciplina char(5),
primary key(codigo),
constraint fk_discOfer_disciplina foreign key (codigoDisciplina) references disciplina (codigo)
);

create table telefone(
cpf char(11) not null,
telefone varchar(10) not null,
primary key(cpf, telefone),
constraint fk_telefone_pessoa foreign key (cpf) references pessoa (cpf)
);

create table horario(
codigo char(5) not null,
horario datetime not null,
primary key(codigo, horario),
constraint fk_horario_discOfer foreign key (codigo) references disciplinaOfertada (codigo)
);

create table cursoProfessor(
cpf char(11) not null,
codigo char(5) not null,
primary key(cpf, codigo),
constraint fk_curso_cp foreign key (codigo) references curso (codigo),
constraint fk_professor_cp foreign key (cpf) references professor (cpf)
);

create table disciplinaLecionada(
cpf char(11) not null,
codigo char(5) not null,
primary key(cpf, codigo),
constraint fk_disciplina_dl foreign key (codigo) references disciplina (codigo),
constraint fk_professor_dl foreign key (cpf) references professor (cpf)
);

create table cursoDisciplina(
codigoCurso char(5) not null,
codigoDisciplina char(5) not null,
primary key(codigoCurso, codigoDisciplina),
constraint fk_curso_cd foreign key (codigoCurso) references curso (codigo),
constraint fk_disciplina_cd foreign key (codigoDisciplina) references disciplina (codigo)
);

create table frequencia(
cpf char(11) not null,
codigo char(5) not null,
data varchar(10) not null,
horarioInicio datetime not null,
horarioFim datetime,
primary key (cpf, codigo),
constraint fk_aluno_fq foreign key (cpf) references aluno(cpf), 
constraint fk_discOfer_fq foreign key (codigo) references disciplinaOfertada (codigo)
);

create table professorDiscOfer(
codigo char(5) not null, 
cpf char(11) not null,
dataInicio varchar (10) not  null,
dataFim varchar (10),
primary key(codigo, cpf),
constraint fk_professor_pd foreign key (cpf) references professor (cpf),
constraint fk_discOfer_pd foreign key (codigo) references disciplinaOfertada (codigo)
);


/*cpf char(11), 
										IN nome varchar(80),
                                        IN dataNasc varchar(10),
                                        IN email varchar (80),
                                        IN logradouro varchar (50),
                                        IN numero smallint,
                                        IN cep varchar(8),
                                        IN bairro varchar(20),
                                        IN complemento varchar(80),
                                        IN codigo char(5),
                                        IN matricula smallint
*/
insert into curso
values (55555, 'TADS');

select * from pessoa;
select * from curso;
select * from professor;
select * from aluno;
select * from disciplina;
select * from disciplinaOfertada;
 
call sp_InserirCurso('00000','Engenharia de Software');
 
call sp_InserirAluno
('00000000002', 'Socorro de Jesus', '10/10/1997',
					 'socorro@gmail.com', 'Rua Deus me Deixou',
					 50, '69000000', 'Tatuapé', 'Nada', '55555',
                     '12345');
                     
call sp_InserirProfessor
('00000000005', 'Joaquim', '10/10/1987',
					 'joaquim@gmail.com', 'Rua Deus me Deixou',
					 50, '69000000', 'Tatuapé', 'Nada',
                     '12345');
                     
call sp_InserirDisciplina
(99988, 'Ensino Religioso Ilimunatti', 6, 'Ensina as artes de dominação mundial');

call sp_InserirDisciplinaOfertada
('TADS2', 'Ensino Religioso Iluminatti', '2016', '2', 99988);