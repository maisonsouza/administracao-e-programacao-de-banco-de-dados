create database Empresa;
use Empresa;

create table funcionario(
	cpf char(11) not null,
    nome varchar(50) not null,
    diaNasc char(2),
    mesNasc char(2),
    anoNasc char(4),
    primary key (cpf)
    );
    
create table departamento(
	codigo int not null,
    nome varchar(50) not null,
    primary key (codigo)
    );
    
create table projeto(
	codigo int not null,
    nome varchar(100) not null,
    ativo char(1),
    dCodigo int not null,
    primary key (codigo),
    foreign key (dCodigo) references departamento(codigo)
    );
    
create table trabalhaEm(
	horas smallint not null,
	fCpf char(11) not null,
    pCodigo int not null,
    primary key (horas),
    foreign key (fCpf) references funcionario(cpf),
    foreign key (pCodigo) references projeto(codigo)
    );
    
