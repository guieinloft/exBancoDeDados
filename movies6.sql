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
select filme.titulo, ator.nome, (if(falec is not null, timestampdiff(year, nasc, falec), timestampdiff(year, nasc, current_date))) idade
from filme, ator
where idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from ator
where (if(falec is not null, timestampdiff(year, nasc, falec), timestampdiff(year, nasc, current_date))) in
(select max(if(falec is not null, timestampdiff(year, nasc, falec), timestampdiff(year, nasc, current_date))) from ator)))
and idAtor in
(select idAtor from ator
where (if(falec is not null, timestampdiff(year, nasc, falec), timestampdiff(year, nasc, current_date))) in
(select max(if(falec is not null, timestampdiff(year, nasc, falec), timestampdiff(year, nasc, current_date))) from ator));
-- 7. Selecionar título, ano e custo de filmes cujo custo de produção seja maior do que o custo médio de produção de todos os filmes.
select titulo, ano, custo from filme where custo >
(select avg(custo) from filme);
-- 8. Selecionar diretores cujo custo médio de produção de filmes seja maior do que o custo médio de produção de todos os filmes.
-- O custo médio de cada diretor também deve ser retornado.
select * from diretor
-- 9. Selecionar o título de filmes que tiveram participação de artistas ou diretores ingleses.

-- 10. Indicar, para cada país, quantas pessoas (diretores ou artistas) nasceram lá.

-- Os próximos exercícios não serão avaliados, mas podem ser entregues junto com os demais.

-- 11. Selecionar título e custo de filmes cujo custo seja maior do que a menor bilheteria.
-- Exibir também o título, o diretor e o custo referentes a essa menor bilheteria.

-- 12. Exibir o título do filme e o título da sua sequência. 
-- O número de artistas de cada filme (original e sequência) também deve ser exibido.

-- 13. Encontrar título de filmes que contaram com pelo menos dois artistas ingleses.
-- Retornar o título e a contagem de artistas correspondente.

-- 14. Encontrar título de filmes que contaram com menos do que dois artistas ingleses.
-- Retornar o titulo e a contagem de artistas correspondente.
-- Obs. Filmes sem artistas ingleses também devem ser retornados.

-- 15. Retornar nomes de diretores que trabalharam tanto com artistas ingleses quanto não ingleses.

-- 16 Para cada artista, retorne o seu nome, o número de filmes em que ele participou e o número de diretores com quem ele trabalhou. 