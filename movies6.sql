-- Complete este script resolvendo as consultas propostas.
-- Entregue pelo moodle em formato PDF.
-- Tente usar subconsultas em todos os casos, mesmo havendo como resolver de outra maneira.

-- 1. Selecionar dados de filmes que tiveram artistas americanos (sem usar o distinct).
select * from filme where idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from ator where pais = "EUA"));

-- 2. Exibir a média de idade dos artistas que já trabalharam com Steven Spielberg.
select avg(if(falec is not null, timestampdiff(year, nasc, falec), timestampdiff(year, nasc, current_date)))
from ator where idAtor in
(select idAtor from elenco where idFilme in
(select idFilme from filme where idDiretor in
(select idDiretor from diretor where nome = "Steven Spielberg")));

-- 3. Exibir nome de artistas que não apareceram em nenhum dos filmes armazenados no banco,
select nome from ator where idAtor not in
(select idAtor from elenco);

-- 4. Retornar nomes de diretores que não trabalharam com Leonardo DiCaprio.
select nome from diretor where idDiretor not in
(select idDiretor from filme where idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from ator where nome = "Leonardo DiCaprio")));

-- 5. Retornar nomes de diretores que contaram com Leonardo DiCaprio em todos os seus filmes.
select idDiretor, nome from diretor where idDiretor in
(select idDiretor from filme where idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from ator where nome = "Leonardo DiCaprio")))
and idDiretor not in
(select idDiretor from filme where idFilme not in
(select idFilme from elenco where idAtor in
(select idAtor from ator where nome = "Leonardo DiCaprio")));

-- 6. Selecionar título de filmes que contaram com a participação do artista mais velho. 
-- Mostrar também o nome do artista e a sua idade.
with tab_idade as (select idAtor, nome, (if(falec is not null, timestampdiff(year, nasc, falec), timestampdiff(year, nasc, current_date))) idade from ator)
select filme.titulo, tab_idade.nome, tab_idade.idade
from filme, tab_idade
where idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from tab_idade
where idade in
(select max(idade) from tab_idade)))
and idAtor in
(select idAtor from tab_idade
where idade in
(select max(idade) from tab_idade));

-- 7. Selecionar título, ano e custo de filmes cujo custo de produção seja maior do que o custo médio de produção de todos os filmes.
select titulo, ano, custo from filme where custo >
(select avg(custo) from filme);

-- 8. Selecionar diretores cujo custo médio de produção de filmes seja maior do que o custo médio de produção de todos os filmes.
-- O custo médio de cada diretor também deve ser retornado.
select diretor.nome, avg(filme.custo)
from diretor natural inner join filme where idDiretor in
(select idDiretor from filme
group by idDiretor
having avg(custo) >
(select avg(custo) from filme))
group by diretor.idDiretor;

-- 9. Selecionar o título de filmes que tiveram participação de artistas ou diretores ingleses.
select titulo from filme where idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from ator where pais = "Inglaterra"))
or idDiretor in
(select idDiretor from diretor where nacionalidade = "Inglaterra");

-- 10. Indicar, para cada país, quantas pessoas (diretores ou artistas) nasceram lá.
select p.pais, count(*) from
((select pais, nome from ator)
union
(select nacionalidade as pais, nome from diretor)) p
group by p.pais;
