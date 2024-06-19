-- Complete este script resolvendo as consultas propostas.
-- Entregue pelo moodle em formato PDF.
-- Tente usar subconsultas em todos os casos, mesmo havendo como resolver de outra maneira.

-- 1. Selecionar dados de filmes que tiveram sequência.
select * from filme where idFilme in
(select idFilmeAnterior from filme);
-- 2. Exibir a média de altura dos artistas que participaram de filmes após o ano 2000.
select avg(ator.altura) from ator where idAtor in
(select elenco.idAtor from elenco natural inner join filme where filme.ano > 2000);
-- 3. Exibir título de filmes que não tiveram nenhum artista registrado.
select titulo from filme where idFilme not in
(select idFilme from elenco);
-- 4. Exibir nomes de artistas que nunca trabalharam com diretores americanos.
select nome from ator where idAtor not in
(select idAtor from elenco where idFilme in
(select idFilme from filme where idDiretor in
(select idDiretor from diretor where diretor.nacionalidade = "EUA")));
-- 5. Exibir nomes de artistas que só trabalharam com diretores americanos.
select nome from ator where idAtor not in
(select idAtor from elenco where idFilme in
(select idFilme from filme where idDiretor in
(select idDiretor from diretor where diretor.nacionalidade != "EUA")))
and idAtor in (select idAtor from elenco);
-- 6. Selecionar título de filmes que contaram com a participação do artista mais alto.
select titulo from filme where idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from ator where altura =
(select max(altura) from ator)));
-- 7. Selecionar nome de diretores que contaram com a participacao do artista mais alto.
select nome from diretor where idDiretor in
(select idDiretor from filme where idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from ator where altura =
(select max(altura) from ator))));
-- 8. Selecionar título e custo de filmes que tiveram o custo maior do que alguma bilheteria.
select titulo, custo from filme where custo > some
(select bilheteria from filme);
-- 9. Retornar uma única coluna contendo nomes de artistas ou diretores que sejam dos Estados Unidos.
(select nome from ator where pais = "EUA")
union
(select nome from diretor where nacionalidade = "EUA");
-- 10. Selecionar a quantidade de pessoas (diretores ou artistas) que sejam dos Estados Unidos.
select count(*) from (
(select nome from ator where pais = "EUA")
union
(select nome from diretor where nacionalidade = "EUA")
) as nomes;
-- Os próximos exercícios não serão avaliados, mas podem ser entregues junto com os demais.

-- 11. Exibir título de filmes que tiveram participantes tanto do sexo masculino quanto feminino.
select titulo from filme where idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from ator where sexo = "F"))
and idFilme in
(select idFilme from elenco where idAtor in
(select idAtor from ator where sexo = "M"));
-- 12. Exibir filmes que não tiveram participantes tanto do sexo masculino quanto feminino.
select titulo from filme where idFilme not in
(select idFilme from elenco where idAtor in
(select idAtor from ator where sexo = "F"))
and idFilme not in
(select idFilme from elenco where idAtor in
(select idAtor from ator where sexo = "M"));
-- 13. Para cada filme exibir três colunas contendo o título, a quantidade de artistas do sexo feminino e a quantidade de artistas do sexo masculino.
select filme.titulo,
(select count(*) from elenco where filme.idFilme = elenco.idFilme and idAtor in
(select idAtor from ator where sexo = "F")) fem,
(select count(*) from elenco where filme.idFilme = elenco.idFilme and idAtor in
(select idAtor from ator where sexo = "M")) masc
from filme;
-- 14. Para cada diretor exibir o seu nome, a quantidade de 
-- artistas do sexo feminino e a quantidade de artistas do sexo masculino com os quais ele já trabalhou.
select diretor.nome,
(select count(*) from filme where diretor.idFilme
-- 15. Exibir o nome do diretor que mais trabalhou com artistas do sexo feminino. 
-- Mostrar a quantidade de artistas respectiva.

-- 16. Retorne quantos filmes estão catalogados considerando a primeira letra do título.
-- O resultado deve exibir a contagem para as letras de A e F, mesmo que a contage seja zero.
