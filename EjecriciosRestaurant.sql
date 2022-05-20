/* 1. Listado de nombre y numero de telefono de los mozos 
*/
select m.nombre, t.numero as numero_telefono from Mozos m, TelefonoMozo t
	where m.idMozo = t.idMozo;


/* 2. Listado de Proveedores sin el código postal.
*/
select razsoc, calle, numero, piso, departamento from Proveedores;


/* 3. Determine la cantidad de Platos
*/
select count(*) from Platos;


/* 4. Determine la cantidad total de facturas
*/
select count(*) from Facturas;

/* 5. Determine la cantidad de ingredientes con una letra f
 *    en la descripción.
 */
select count(*) from Ingredientes where descripcion like '%f%';

/* 6. Determine cuantas mesas hay en el sector 3
*/
select count(*) from Mesas where idSector = 3;

/* 7. Determine la menor cantidad en stock de los ingredientes.
*/
select min(stock) from Ingredientes;

/* 8. El promedio de platos en las facturas
*/
select avg(platosPorFactura.suma) from (
	select sum(cantida) as suma 
		from ItemsFactura group by NroFactura
) as platosPorFactura

/* 9. Determine la cantidad total de unidades en stock de
 *    todos los ingredientes.
 */
select sum(stock) from Ingredientes

/* 10. Determine La cantidad de ítems de la factura 6.
 */
select sum(cantida) from ItemsFactura where NroFactura = 6

/* 11. Mostrar el importe de cada factura.
*/
select total from Facturas

/* 12. El mayor monto de una factura.
 */
select montos.NroFactura, montos.maxMonto from (
	select NroFactura, max(precio) maxMonto from ItemsFactura
		group by NroFactura
) as montos

/* 13. Liste los ingredientes y su cantidad en existencia, si la
 * misma es menor o igual al punto de reposición.
 */
select descripcion, stock from Ingredientes where stock < puntoRep

/*
 * 14. Liste los ingredientes y su precio en los casos en que la
 * cantidad a comprar sea 1 
 */
select descripcion, precComp from Ingredientes where cantComp = 1

/*
 * 15. Liste los teléfonos de proveedores con código de área igual a 1 */select numero from TelefonoProveedor where codArea = 1 /* * 16. Muestre el código postal de la localidad de Tigre */select IdCodpos from Localidades where localida like '%tigre%'/* * 17. Muestre los números de factura, su total y la fecha de emisión, * de las facturas del mes de enero. */select * from Facturas where 	fechaApertura >= '2009-01-01' and fechaApertura <= '2009-01-31'/* * 18. Liste la cantidad de ventas por mozo. */select Mozos.IdMozo, nombre, totalFacturas from (	(select IdMozo, count(*) totalFacturas from Facturas group by IdMozo) as Cuentas right join	Mozos on Cuentas.IdMozo = Mozos.IdMozo)