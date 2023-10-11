-- Source: https://www.discoduroderoer.es/ejercicios-propuestos-y-resueltos-sakila-mysql/

-- 1. Actores que tienen de primer nombre ‘Scarlett’.
select * from actor where first_name = 'Scarlett';

-- 2. Actores que tienen de apellido ‘Johansson’.
select * from actor where last_name = 'Johansson';

-- 3. Actores que contengan una ‘O’ en su nombre.
select * from actor where first_name like '%O%';

-- 4. Actores que contengan una ‘O’ en su nombre y en una ‘A’ en su apellido.
select * from actor
    where first_name like '%O%' and last_name like '%A%';

-- 5. Actores que contengan dos ‘O’ en su nombre y en una ‘A’ en su apellido.
select * from actor
    where len(first_name) - len(REPLACE(first_name, 'O', '')) = 2
        and last_name like '%A%';

-- 6. Actores donde su tercera letra sea ‘B’.
select * from actor where first_name like '__B%';

-- 7. Ciudades que empiezan por ‘a’.
select * from city c where c.city like 'a%';

-- 8. Ciudades que acaban por ‘s’.
select * from city c where c.city like '%s';

-- 9. Ciudades del country 61.
select * from city where country_id = 61;

-- 10. Ciudades del country ‘Spain’.
select * from city
    where country_id = (
        select country_id from country co where co.country = 'Spain'
    );

-- 11. Ciudades con nombres compuestos.
-- select * from city ci
--     where len(ci.city) - len(REPLACE(ci.city, ' ', '')) > 0;

select * from city ci
    where city like '% %';

-- 12. Películas con una duración entre 80 y 100.
select * from film where length BETWEEN 80 and 100
    order by replacement_cost asc;

-- 13. Peliculas con un rental_rate entre 1 y 3.
select * from film where rental_rate BETWEEN 1 and 3;

-- 14. Películas con un titulo de más de 12 letras.
select * from film where len(title) >= 12;

-- 15. Peliculas con un rating de PG o G.
select * from film where rating in ('PG', 'G');

-- 16. Peliculas que no tengan un rating de NC-17.
select * from film where rating != 'NC-17';

-- 17. Peliculas con un rating PG y duracion de más de 120.
select * from film where rating = 'PG' and length > 120;

-- 18. ¿Cuantos actores hay?
select count(*) as count_actores from actor;

-- 19. ¿Cuántas ciudades tiene el country ‘Spain’?
select count(*) as count_cities
    from city
    where country_id = (
        select country_id from country co
            where co.country = 'Spain'
    );

-- 20. ¿Cuántos countries hay que empiezan por ‘a’?
select count(*) as count_countries from country co
    where co.country like 'a%';


-- 21. Media de duración de peliculas con PG.
select AVG(film.length) as avg_len from film
    where rating = 'PG';

-- 22. Suma de rental_rate de todas las peliculas.
select sum(rental_rate) as total_rental_rate from film;

-- 23. Pelicula con mayor duración.
-- select max(film.length) as max_len from film;
select * from film where film.length >= (
    select max(film.length) from film
);

-- 24. Película con menor duración.
-- select min(film.length) from film;
select * from film where film.length <= (
    select min(film.length) from film
);

-- 25. Mostrar las ciudades del country Spain (multitabla).
select city_id from city where city.country_id = (
    select country_id from country co where co.country = 'Spain'
);


-- 26. Mostrar el nombre de la película y el nombre de los actores.
select actor.first_name, actor.last_name, film.title
    from film_actor
    left join actor on actor.actor_id = film_actor.actor_id
    left join film on film.film_id = film_actor.film_id;

-- 27. Mostrar el nombre de la película y el de sus categorías.
select fi.title film_name, cat.name category
    from film_category fc
    left join film fi on fi.film_id = fc.film_id
    left join category cat on cat.category_id = fc.category_id;

-- 28. Mostrar el country, la ciudad y dirección de cada miembro del staff.
select
    staff.first_name,
    staff.last_name,
    co.country,
    ci.city,
    ad.address,
    ad.address2
from staff
left join address ad on ad.address_id = staff.address_id
left join city ci on ci.city_id = ad.city_id
left join country co on co.country_id = ci.country_id;

-- 29. Mostrar el country, la ciudad y dirección de cada customer.
select
    customer.first_name,
    customer.last_name,
    co.country,
    ci.city,
    ad.address,
    ad.address2
from customer
left join address ad on ad.address_id = customer.address_id
left join city ci on ci.city_id = ad.city_id
left join country co on co.country_id = ci.country_id;

-- 30. Numero de películas de cada rating
select rating, count(*)
from film
group by rating;

-- 31. Cuantas películas ha realizado el actor ED CHASE.
select
    count(*) movie_count,
    ac.first_name,
    ac.last_name
from film fi
left join film_actor fa on fa.film_id = fi.film_id
left join actor ac on ac.actor_id = fa.actor_id
where
    ac.first_name = 'ED' and ac.last_name = 'CHASE'
group by ac.first_name, ac.last_name;

-- 32. Media de duración de las películas cada categoría.
select ca.name, avg(fi.length) as med_len
from film_category fc
left join category ca on ca.category_id = fc.category_id
left join film fi on fi.film_id = fc.film_id
group by ca.name
order by ca.name asc;
