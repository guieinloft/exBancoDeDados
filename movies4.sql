-- Complete este script resolvendo as consultas propostas.
-- Entregue pelo moodle em formato PDF.
use movies;
-- 1. Selecionar filmes que possuam artistas com mais do que 1.9m de altura. 
-- Exibir título do filme, bem como nome do artista e sua altura.
select f.titulo
from filme f
natural join elenco e
natural join ator a
where a.altura > 1.9;
-- 2. Para cada país, exibir quantos artistas já atuaram. 
-- O mesmo artista não pode ser contabilizado mais do que uma vez.
select a.pais, count(distinct a.idAtor)
from ator a
natural join elenco e
natural join filme f
group by a.pais;
-- 3. Exibir nomes de artistas que não atuaram em nenhum filme.
select a.nome
from ator a
natural left join elenco e
where e.idFilme is null;
-- 4. Selecionar título de filmes que foram sequência de outro filme.
select f.titulo
from filme f
where f.idFilmeAnterior is not null;
-- 5. Exibir nome de diretores que não dirigiram nada entre 2005 e 2010.
select d.nome
from diretor d
natural left join filme f
where f.ano between 2005 and 2010 and f.idFilme is null;
-- 6.	Exibir nome de artistas e a bilheteria somada de todos seus filmes. 
-- Ordenar pela bilheteria.
select a.nome, sum(f.bilheteria)
from ator a 
natural inner join elenco e
natural inner join filme f
group by a.idAtor;
-- 7. Exibir a maior e a menor bilheteria de cada artista.
-- Apenas para artistas que tenha pelo menos dois filmes.
select a.nome, max(f.bilheteria), min(f.bilheteria)
from ator a 
natural inner join elenco e
natural inner join filme f
group by a.idAtor
having count(f.idFilme) > 1;
-- 8. Para cada diretor, exibir seu nome, nome do artista com quem ele traballhu e a quantidade de trabalhos realizados. 
-- Observe que cada diretor pode gerar vários agrupamentos, um para cada artista com quem ele trabalhou.
select diretor.nome, ator.nome, count(*)
from diretor
inner join filme on diretor.idDiretor = filme.idDiretor
inner join elenco on filme.idFilme = elenco.idFilme
inner join ator on elenco.idAtor = ator.idAtor
group by diretor.idDiretor, ator.idAtor;
-- 9. Exibir título de filmes que tiveram participantes do sexo feminino.
select filme.titulo
from filme
inner join elenco on filme.idFilme = elenco.idFilme
inner join ator on elenco.idAtor = ator.idAtor
where ator.sexo = "F";
-- 10. Exibir título de filmes que não tiveram participantes do sexo feminino.
select filme.titulo
from filme
where filme.idFilme not in
(select filme.idFilme
from filme
inner join elenco on filme.idFilme = elenco.idFilme
inner join ator on elenco.idAtor = ator.idAtor
where ator.sexo = "F");
-- Os próximos exercícios não serão avaliados, mas podem ser entregues junto com os demais.

-- 11. Para cada diretor, exibir seu nome e a quantidade de artistas do sexo feminino com os quais ele já trabalhou. 
select diretor.nome, count(distinct ator.idAtor)
from diretor
inner join filme on diretor.idDiretor = filme.idDiretor
inner join elenco on filme.idFilme = elenco.idFilme
inner join ator on elenco.idAtor = ator.idAtor
where ator.sexo = "F"
group by diretor.idDiretor;
-- 12. Para cada diretor, exibir seu nome e a quantidade de artistas ingleses com os quais ele já trabalhou. 
-- Diretores que não trabalharam com artistas ingleses devem receber a contagem zero. 
select diretor.nome, count(distinct ator.idAtor)
from diretor
left join filme on diretor.idDiretor = filme.idDiretor
left join elenco on filme.idFilme = elenco.idFilme
left join ator on elenco.idAtor = ator.idAtor
where ator.pais like "Inglaterra"
group by diretor.idDiretor;
-- 13. Exibir título de filmes que tiveram participantes tanto do sexo masculino quanto feminino.
select filme.titulo
from filme
where filme.idFilme in
(select filme.idFilme
from filme
inner join elenco on filme.idFilme = elenco.idFilme
inner join ator on elenco.idAtor = ator.idAtor
where ator.sexo = "F") and filme.idFilme in
(select filme.idFilme
from filme
inner join elenco on filme.idFilme = elenco.idFilme
inner join ator on elenco.idAtor = ator.idAtor
where ator.sexo = "M");
-- 14. Para cada par de artistas que contracenou junto, mostrar o número de filmes em que ambos apareceram.
select count(filme.idFilme)
from ator
-- 15. Mostrar títulos do filmes em que tanto Michael Cane quanto Morgan Freeman contracenaram.

-- 16. Retorne quantos filmes estão catalogados considerando a primeira letra do título. 
