-- 1. Selecione título de filmes que comecem com 'batman'.
select *
    from filme
    where titulo like "batman%";
-- 2. Exibir o título e ano de filmes lançados entre 2010 e 2015. 
-- Renomeie a coluna ano para ‘lancamento’. 
-- Coloque os resultados em ordem ascendente de ano.	
select titulo, ano as lancamento
    from filme
    where ano between 2010 and 2015
    order by ano asc;
-- 3. Selecionar os anos de lançamento de filmes (sem repeti-los). 
-- Retornar por ordem ascendente de ano.	
select distinct ano
    from filme
    order by ano asc;
-- 4. Selecionar a quantidade de anos distintos em que foram lançados filmes.
select count(distinct ano)
    from filme;
-- 5. Selecionar o número de filmes lançados por ano. 
-- Ordene pela contagem.	
select distinct ano, count(idFilme)
    from filme
    group by ano
    order by count(idFilme) asc, ano asc;
-- 6. Exibir nome de diretores e o título de seus filmes.
select d.nome, f.titulo
    from diretor d, filme f
    where d.idDiretor = f.idDiretor;
-- 7. Selecionar título e ano de filmes dirigidos por Steven Spielberg. 
-- Ordene pelo ano.
select f.titulo, f.ano
    from filme f, diretor d
    where d.idDiretor = f.idDiretor and d.nome = "Steven Spielberg"
    order by f.ano;
-- 8. Retornar nomes de diretores juntamente com o número de filmes que cada um dirigiu.
select distinct d.nome, count(f.idFilme)
    from diretor d, filme f
    where f.idDiretor = d.idDiretor
    group by d.nome order by count(f.idFilme);
-- 9. Retornar nome de diretores juntamente com o número de filmes que cada um dirigiu.
-- Mostrar o diretor apenas caso o número de filmes dirigido seja maior do que 2.
select distinct d.nome, count(f.idFilme)
    from diretor d, filme f
    where f.idDiretor = d.idDiretor
    group by d.nome
    having count(f.idFilme) > 2
    order by count(f.idFilme);
-- 10. Para cada diretor, retornar o ano em que teve o primeiro filme lançado.
select distinct d.nome, min(f.ano)
    from diretor d, filme f
    where f.idDiretor = d.idDiretor
    group by d.nome
    order by f.ano;
-- Os próximos exercícios não serão avaliados, mas podem ser entregues junto com os anteriores

-- 11. Selecione a média de idade dos artistas.
select avg(if(falec is not null, timestampdiff(year, nasc, falec), timestampdiff(year, nasc, current_date))) as idade
    from ator;
-- 12. Para cada filme, exibir o título, o ano e o lucro, sendo que o lucro é a diferença entre a bilheteria e o custo. 
-- Mostrar o resultado na ordem dos milhões. 
-- Ordene do maior para o menor valor. 
select titulo, ano, (bilheteria - custo)/1000000 as lucro
    from filme
    order by lucro desc;
-- 13. Para cada diretor, mostrar a diferença entre a sua maior e menor bilheteria. 
-- Mostrar a resposta na ordem dos milhões.
select d.nome, (max(f.bilheteria) - min(f.bilheteria))/1000000 as dif
    from diretor d, filme f
    where d.idDiretor = f.idDiretor
    group by d.idDiretor
    order by dif desc;
-- 14. Exibir o nome dos artistas e seu país de origem. 
-- Países do Reino Unido (Irlanda do Norte,Escocia, Inglaterra,Pais de Gales) devem ser exibidos como Reino Unido. 
select nome, case pais
    when "Escocia" then "Reino Unido"
    when "Inglaterra" then "Reino Unido"
    when "Irlanda do Norte" then "Reino Unido"
    when "País de Gales" then "Reino Unido"
    else pais
    end as nacionalidade
    from ator;
-- 15. Exibir o país e a quantidade de artistas de cada país. 
-- Países do Reino Unido (Irlanda do Norte,Escocia, Inglaterra,Pais de Gales) devem ser agrupados como uma única entrada, referente ao Reino Unido. 
select case pais
    when "Escocia" then "Reino Unido"
    when "Inglaterra" then "Reino Unido"
    when "Irlanda do Norte" then "Reino Unido"
    when "País de Gales" then "Reino Unido"
    else pais
    end as nacionalidade, count(idAtor)
    from ator
    group by nacionalidade;
-- 16. Exiba títulos de filmes cuja primeira letra seja 'A'.
select titulo
    from filme
    where titulo like "A%";
