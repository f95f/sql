create database P1;

-- 1 a)	 ------------------------------------------------------------------------------------------------------------------------------------------------
use hr;

-- 2.	 ------------------------------------------------------------------------------------------------------------------------------------------------
use hospital3;
create view vw_paciente_consultado as
	select
		nome,
        data_nascimento,
        genero,
        dna,
        altura,
        peso,
        comorbidades
	from
		paciente;
        
select * from vw_paciente_consultado;

-- 3.	 ------------------------------------------------------------------------------------------------------------------------------------------------
use hospital3;

create index IND_especialidade on medico(especialidade);

explain select * from medico where especialidade like 'pediatra';

-- 4 a) ------------------------------------------------------------------------------------------------------------------------------------------------
use P1;
CREATE TABLE comentario( 
	id INT AUTO_INCREMENT,
	comentario text NOT NULL,
	autor VARCHAR(255),
	data DATE,
	PRIMARY KEY (id)
); -- tabela para testes

delimiter $

create trigger tgr_novo_comentario
before insert
on comentario for each row
begin
	set new.comentario = concat(" > ", new.autor, ", em ", new.data, ", escreveu: ", new.comentario);
end $

delimiter ;

insert into comentario values(
	null,
    "alguma coisa.",
    "João",
    now()
);

select * from comentario;

-- 4 b) ------------------------------------------------------------------------------------------------------------------------------------------------
delimiter $

create trigger tgr_mil_likes
after insert
on comentario for each row
begin
	if row_count() = 1000 then
		--
    end if;
end $

delimiter ;

-- 5.	------------------------------------------------------------------------------------------------------------------------------------------------
use P1;
CREATE TABLE membros(
	id INT AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(255),
	dataNascimento DATE,
	PRIMARY KEY (id)
);

CREATE TABLE lembrete(
	id INT AUTO_INCREMENT,
	membroId INT,
	mensagem VARCHAR(255) NOT NULL,
	PRIMARY KEY (id , membroId)
);

delimiter $

create trigger tgr_lembrete_aniversario
before insert on membros
for each row
begin
	if (month(new.dataNascimento) = month(now())) and (day(new.dataNascimento) <= (day(now()) + 7)) then 
    -- date_add(new.dataNascimento, interval 7 day) then
		insert into lembrete(mensagem) 
        values(concat("Olá, membros, o aniversário de ", new.nome, " é daqui a 7 dias. Vamos comprar uma lembrança para ele?"));
	end if;
end $

delimiter ;

-- Não usa o trigger:
insert into membros(nome, email, dataNascimento) values(
	"john",
    "john@sail.com",
    '1999-05-05'
);

-- Usa o trigger:
insert into membros(nome, email, dataNascimento) values(
	"joahna",
    "joahna@mail.com",
    '1999-04-20'
);

select * from membros;
select * from lembrete;

-- 6.	------------------------------------------------------------------------------------------------------------------------------------------------
use P1;
Create table produto(
	idProduto int not null auto_increment,
	nome varchar(45) null,
	preco_normal decimal(10,2) null,
	preco_desconto decimal(10,2) null,
	primary key (idProduto)
);

delimiter $

create trigger tgr_atualizar_desconto
before insert on produto 
for each row
begin
set new.preco_desconto = (new.preco_normal - new.preco_normal * 0.08);
end $

delimiter ;

insert into produto(nome, preco_normal) values("Pão", 10.00);
select * from produto;

-- 7.	 ------------------------------------------------------------------------------------------------------------------------------------------------
use P1;