/* drop do banco de dados*/
drop database cad_equipe

/* criaçao do banco de dados*/
create database cad_equipe

use cad_equipe

go

/* criaçao da tabela jogador*/
create table jogador
(id_jogador int identity not null primary key,
nm_jogador varchar (20) not null,
funcao_jogador varchar(20) not null,
qtd_jogador int not null,
id_rota   int  not null  constraint tipo_rota_id_rota  references tipo_rota (id_rota),
id_equipe  int   not null  constraint equipe_id_equipe   references equipe (id_equipe));


go
/* criaçao da tabela campeonato*/
create table campeonato
(id_campeonato int identity not null  primary key,
nm_campeonato varchar (45) not null,
data_inicio_campeonato date not null,
data_termino_campeonato date not null,
id_equipe    int  not null  constraint equipe_id_fk   references equipe (id_equipe));
go
 
 /* criaçao da tabela equipe*/
create table equipe
(id_equipe int identity   not null primary key,
 nm_equipe varchar (20) not null,
  rank_equipe int not null ,
data_entrada_equipe date not null,
data_saida_equipe date,
min_equipe int not null,
max_equipe int not null);   
go

/*criaçao da tabela tipo_rota* refazer a tabela*/
create table tipo_rota
(id_rota int identity not null primary key ,
nm_rota varchar(45) not null,
dsc_rota varchar(45)not null );


/* select das tabelas*/
select * from equipe
go

select *from tipo_rota
go
select * from jogador
go
select * from campeonato

/*drop das tabelas*/
drop table equipe
go

drop table tipo_rota
go

drop table jogador
go

drop table campeonato
go


/* alter table  caso precise ser usado*/ 

 alter table camepeonato
add constraint fk_equipe foreign key (id_equipe) references
equipe (id_equipe);      

/* futuros inserts que serao feitos no sistema */

insert into tipo_rota  (nm_rota , dsc_rota)
values ('topo', 'top lane'),
       ('meio', 'mid lane'),
       ('selva', 'jungle' ),
       ('bot',  'bot lane');
	    
go
insert into equipe (nm_equipe,rank_equipe,data_entrada_equipe,data_saida_equipe,min_equipe,max_equipe )
 values ('intz',5 , '2001-07-23','2001-08-02',5,10 );
 go

insert into   jogador (nm_jogador, funcao_jogador,qtd_jogador,id_rota,id_equipe)
values  ('gustavo xavier','suporte',1,4,6);


--insert into jogador (nm_jogador, funcao_jogador,id_rota,id_equipe) 
--values ('gustavo xavier','topo','');

insert into campeonato (id_campeonato,nm_campeonato,data_inicio_campeonato,data_termino_campeonato)
 values (1,'cblol', '2019-07-12', '2019-07-22');
go

/* alter table da da tabela jogador*/
alter table jogador
drop column nm_jogador;



/* select das tabelas*/
select* from jogador

select* from campeonato

select * from tipo_rota


select id_jogador 'Codigo do jogador',funcao_jogador as' Funcao do jogador' 
from  jogador
where qtd_jogador = 05;


select id_equipe 'Codigo da euipe',nm_equipe as 'Nome da equipe'
from equipe
where rank_equipe=01;


select id_equipe as 'Codigo da equipe', nm_equipe as 'Nome da equipe', min_equipe ' minimo da equipe', max_equipe 'maximo da equipe' 
from equipe
where data_entrada_equipe between '2019-06-03' and '2019-07-03'

/* update  das tabelas equipe e jogador*/
select * from equipe;

update equipe
set    nm_equipe = 'pain'
where  id_equipe = 2;

select * from jogador;

update jogador
set nm_jogador ='brtt'
where id_jogador =1;

select * 
from equipe 
where nm_equipe like'i%'

   /* join  */
select  e.id_equipe'codigo da equipe',e.nm_equipe 'Nome da equipe', 
from equipe e 
     join equipe e on  a.id_equipe = c.id_equipe;
			  
 
select  e.id_are 'Codigo da equipe', e.nm_equipe as 'Nome da equipe',e.nm_jogador  as 'Nome do Jogador' , nm_campeonato as 'Nome do Campeonato'
from equipe e  , jogador j , camepeonato c
 join equipe a on e.id_equipe = e.id_equipe
where id_equipe =2;
 

 /* subquery */
 select  id_equipe , nm_equipe,
from professor
where rank_equipe >(select AVG (vl_hora_prof) from equipe)
ORDER BY rank_equipe asc 

select data_entrada_equipe  
from equipe
 where data_entrada_equipe >'2019-06-03' (select (data_entrada_equipe) from equipe) 

			
/* view  */

create view jogador_posicao
as select rank_equipe 'Rank da equipe'
from equipe
where  rank_equipe > 1;			
 
select *from jogador_posicao
 
 /* funçoes de grupo */

/* select  da tabela equipe usando COUNT*/
select COUNT (qtd_jogador)  "Quantidade de jogadores"
from equipe;
go


/* select com funcao de achar dados que nao estao nulos com clausura where */
select  rank_equipe,data_entrada_equipe
from equipe
where min_equipe IS NULL;
go


/* select com funcao de grupo de pegar o minimo  e o maximo de cada coluna */
select MIN (min_equipe) "quantidade minima da equipe", MAX (max_equipe) "quantidade maxima da equipe"
FROM equipe;
go


/* select com funcao de grupo de soma somando a quantidade minima e a maxima das duas colunas */ 
select SUM   (min_equipe) as "quantidade minima da equipe", SUM  (max_equipe) as "Quantidade maxima da equipe"
from equipe
where rank_equipe  IS NOT NULL
GROUP BY  id_equipe
ORDER BY id_equipe desc


