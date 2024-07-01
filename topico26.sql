-- Complete este script resolvendo as consultas propostas.
-- Entregue pelo moodle em formato PDF.
use movies;
-- 1. Exibir dados de artistas que nasceram em países do Reino Unido.
select * from ator
where pais like "Reino Unido"
or pais like "Inglaterra"
or pais like "Escocia"
or pais like "Pais de Gales"
or pais like "Irlanda do Norte";
-- 2. Para cada artista, exibir seu nome e o intervalo de anos entre o seu filme mais antigo e o mais recente.
-- Considerar apenas os casos em que o artista tenha realizado mais do que um filme.
select ator.nome, (max(filme.ano) - min(filme.ano)) as intervalo
from ator natural join elenco natural join filme
group by ator.nome
having count(*) > 1;
-- 3. Exibir nomes de diretores que só dirigiram um filme.
select diretor.nome
from diretor inner join filme on diretor.idDiretor = filme.idDiretor
group by diretor.nome
having count(*) = 1;
-- 4. Exibir título, custo e bilheteria de filmes cujo custo foi menos de 20% do valor arrecadado em bilheteria.
select titulo, custo, bilheteria
from filme
where custo < bilheteria/5;
-- 5. Selecione o sexo e a média de idade dos artistas, por sexo. 
-- Use 'Masculino' e 'Feminimo' na resposta.
with idade as (select idAtor, nome, sexo, (if(falec is not null,
timestampdiff(year, nasc, falec), timestampdiff(year, nasc,
current_date))) idade from ator)
select case sexo
when "M" then "Masculino"
when "F" then "Feminino"
end as sexo, avg(idade) from idade
group by sexo;
-- 6. Retornar, para cada filme, o título e a quantidade de artistas do sexo feminino.
select filme.titulo, count(ator.idAtor)
from filme natural left join elenco
left join ator on ator.idAtor = elenco.idAtor and ator.sexo = "F"
group by filme.idFilme;
-- 7. Encontrar diretores que atuaram em seus próprios filmes.
-- Para cada ocorrência encontrada, retornar o nome do diretor e o título do filme.
select diretor.nome, filme.titulo
from diretor inner join filme on diretor.idDiretor = filme.idDiretor
inner join elenco on filme.idFilme = elenco.idFilme
inner join ator on elenco.idAtor = ator.idAtor
where diretor.nome = ator.nome;
-- 8. Selecionar título de filmes e bilheteria para casos em que a bilheteria seja menor do que o custo de produção de todos os filmes do Christopher Nolan.
select titulo, bilheteria
from filme where bilheteria < all
(select custo from filme
inner join diretor on filme.idDiretor = diretor.idDiretor
where diretor.nome like "Christopher Nolan");
-- 9. Selecionar título de filmes que tiveram o custo maior do que a bilheteria de todos os filmes de roberto benigni. 
-- O custo também deve ser exibido.
select titulo, custo
from filme where custo > all
(select bilheteria from filme
inner join diretor on filme.idDiretor = diretor.idDiretor
where diretor.nome like "Roberto Benigni");
-- 10. Selecionar filmes que tiveram o custo maior do que a bilheteria de todos os filmes de algum diretor.
-- Mostrar o custo também. 
select titulo, custo
from filme where custo > some
(select max(bilheteria) from filme
inner join diretor on filme.idDiretor = diretor.idDiretor
group by filme.idDiretor);