-- 1. Diseñe una consulta SQL que utilice un cursor para recorrer
-- todos los actores en la base de datos sakila y muestre sus nombres.

DECLARE @Nombre NVARCHAR(100);
DECLARE @Apellido NVARCHAR(100);

DECLARE USER_CURSOR CURSOR FOR
SELECT first_name, last_name from actor;

OPEN USER_CURSOR;

FETCH NEXT FROM USER_CURSOR into @Nombre, @Apellido;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Nombre: ' + @Nombre + ' Apellido: ' + @Apellido;
    FETCH NEXT FROM USER_CURSOR into @Nombre, @Apellido;
END;

CLOSE USER_CURSOR;
DEALLOCATE USER_CURSOR;

-- 3. En la base de datos sakila, diseñe una consulta SQL que
-- devuelva los nombres de los clientes que han alquilado
-- películas en la categoría "Comedy" durante el año 2006.

SELECT * from customer cu
WHERE cu.customer_id in (
    SELECT DISTINCT re.customer_id FROM rental re
    LEFT JOIN inventory inv on inv.inventory_id = re.inventory_id
    LEFT JOIN film fi on fi.film_id = inv.film_id
    LEFT JOIN film_category fica on fica.film_id = fi.film_id
    WHERE
        YEAR(re.rental_date) = '2006' and
        fica.category_id = (
            SELECT cat.category_id from category cat
            where name = 'Comedy'
        )
);
