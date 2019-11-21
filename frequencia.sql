create database frequencia;
-- drop database frequencia;
use frequencia;

create table pessoa(
matricula smallint unsigned not null,
nome varchar(80) not null,
cpf char(11) not null,
dataNasc varchar(10),
email varchar(80),
logradouro varchar(50),
numero smallint,
cep varchar(8),
bairro varchar(20),
complemento varchar(80),
primary key(matricula)
);

create table professor(
matricula smallint unsigned not null,
primary key(matricula),
constraint fk_professor_pessoa foreign key(matricula) references pessoa(matricula)  
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
matricula smallint unsigned not null,
codigo char(5), 
primary key(matricula),
constraint fk_aluno_pessoa foreign key(matricula) references pessoa (matricula),
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
matricula smallint unsigned not null,
telefone varchar(10) not null,
primary key(matricula, telefone),
constraint fk_telefone_pessoa foreign key (matricula) references pessoa (matricula)
);

create table horario(
codigo char(5) not null,
horario datetime not null,
primary key(codigo, horario),
constraint fk_horario_discOfer foreign key (codigo) references disciplinaOfertada (codigo)
);

create table cursoProfessor(
matricula smallint unsigned not null,
codigo char(5) not null,
primary key(matricula, codigo),
constraint fk_curso_cp foreign key (codigo) references curso (codigo),
constraint fk_professor_cp foreign key (matricula) references professor (matricula)
);

create table disciplinaLecionada(
matricula smallint unsigned not null,
codigo char(5) not null,
primary key(matricula, codigo),
constraint fk_disciplina_dl foreign key (codigo) references disciplina (codigo),
constraint fk_professor_dl foreign key (matricula) references professor (matricula)
);

create table cursoDisciplina(
codigoCurso char(5) not null,
codigoDisciplina char(5) not null,
primary key(codigoCurso, codigoDisciplina),
constraint fk_curso_cd foreign key (codigoCurso) references curso (codigo),
constraint fk_disciplina_cd foreign key (codigoDisciplina) references disciplina (codigo)
);

create table frequencia(
matricula smallint unsigned not null,
codigo char(5) not null,
data varchar(10) not null,
horarioInicio datetime not null,
horarioFim datetime,
primary key (matricula, codigo),
constraint fk_aluno_fq foreign key (matricula) references aluno(matricula), 
constraint fk_discOfer_fq foreign key (codigo) references disciplinaOfertada (codigo)
);

create table professorDiscOfer(
codigo char(5) not null, 
matricula smallint unsigned not null,
dataInicio varchar (10) not  null,
dataFim varchar (10),
primary key(codigo, matricula),
constraint fk_professor_pd foreign key (matricula) references professor (matricula),
constraint fk_discOfer_pd foreign key (codigo) references disciplinaOfertada (codigo)
);