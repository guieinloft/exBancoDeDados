-- Complete este script resolvendo as consultas propostas.
-- Entregue pelo moodle em formato PDF.
use movies;
-- 1. Selecionar dados de artistas que já faleceram.
select * from ator where falec is not null;
-- 2. Retornar o nome e altura de atrizes, da mais alta para a mais baixa.
select nome, altura from ator
where sexo = "F"
order by altura desc;
-- 3. Mostrar uma contagem das alturas dos artistas. 
-- Exibir a altura apenas caso ela seja compartilhada por pelo menos dois artistas. 
-- Não exibir a contagem dos artistas cuja altura não foi informada.
select altura, count(*) qtd from ator
where altura is not null
group by altura
having qtd > 1;
-- 4. Exibir o título e a média de altura dos artistas de cada filme. 
select f.titulo, avg(a.altura)
from filme f natural inner join elenco e natural inner join ator a
where altura is not null
group by f.titulo;
-- 5. Exibir o país de origem e a quantidade de filmes que contarem com artistas daquele país. 
select a.pais, count(*)
from ator a natural inner join elenco e natural inner join filme f
group by a.pais;
-- 6. Exibir a quantidade de filmes por nacionalidade e sexo dos artistas envolvidos.
-- Ou seja, deve ser exibida uma contagem para cada par de país e sexo. 
select a.pais, a.sexo, count(*)
from ator a natural inner join elenco e natural inner join filme f
group by a.pais, a.sexo;
-- 7. Para cada filme, retornar o título, o diretor e a quantidade de artistas.  
select f.titulo, d.nome, count(*)
from filme f natural join elenco e natural join ator a
inner join diretor d on d.idDiretor = f.idDiretor
group by f.titulo, d.nome;
-- 8. Retornar nome do artista e título dos filmes estrelados por artistas cujo nome comece com 'Tom'.
select a.nome, f.titulo
from ator a natural inner join elenco e natural inner join filme f
where a.nome like "Tom %";
-- 9. Mostrar título, ano e os artistas de cada filme produzido entre 2008 e 2009. 
-- Filmes sem artistas registrados também devem ser exibidos.
select f.titulo, f.ano, a.nome
from filme f natural join elenco e natural join ator a
where f.ano between 2008 and 2009;
-- 10. Mostrar título de filmes e a contagem de artistas. 
-- Filmes sem artistas devem receber a contagem zero.
select f.titulo, count(a.nome)
from filme f natural join elenco e natural join ator a
group by f.titulo;
-- Os próximos exercícios não serão avaliados, mas podem ser entregues junto com os demais.

-- 11. Retornar o título do filme, o nome do diretor e de seus artistas.

-- 12. Retornar o título do filme, o nome do diretor e de seus artistas.
-- Filmes sem artistas também devem ser retornados (no caso, Avatar).

-- 13. Retornar o título do filme, o nome do diretor.
-- Apenas filmes sem artistas devem ser retornados (no caso, Avatar).

-- 14. Exibir duas colunas. Uma contendo o título do filme e outra exibindo a sua sequência.
-- Filmes sem sequência não precisam ser retornados.

-- 15. Exibir duas colunas. Uma contendo o título do filme e outra exibindo a sua sequência.
-- Filmes sem sequência também precisam ser retornados.

-- 16. Exibir o título do filme e o título da sua sequência. 
-- O diretor de cada filme deve ser exibido.
-- Filmes sem sequência também precisam ser retornados.