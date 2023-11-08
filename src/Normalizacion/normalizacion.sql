-- Creación Tabla Original
CREATE TABLE OrdenesoRIGINAL
(id_orden int,
fecha date,
id_cliente int,
nom_cliente char(20),
estado char(20),
num_art int,
nom_art char(20),
cant int,
precio real)

INSERT INTO OrdenesoRIGINAL values
(2301,'2011/02/23',101,'Martín','Caracas',3786,'Red',3,35.00),
(2301,'2011/02/23',101,'Martín','Caracas',4011,'Raqueta',6,65.00),
(2301,'2011/02/23',101,'Martín','Caracas',9132,'Paq-3',4,4.75),
(2302,'2011/02/25',107,'Hernan','Coro',5794,'Paq-6',4,5.00),
(2303,'2011/02/27',110,'Pedro','Maracay',4011,'Raqueta',2,65.00),
(2303,'2011/02/27',110,'Pedro','Maracay',3141,'Funda',2,10.00)

-- SELECT * FROM Ordenes

-- 1NF
CREATE TABLE Ordenes
(id_orden int,
fecha date,
id_cliente int,
nom_cliente char(20),
estado char(20))

CREATE TABLE ArticulosOrdenes
(id_orden int,
num_art int,
nom_art char(20),
cant int,
precio real)

INSERT INTO Ordenes values
(2301,'2011/02/23',101,'Martín','Caracas'),
(2302,'2011/02/25',107,'Hernan','Coro'),
(2303,'2011/02/27',110,'Pedro','Maracay')


INSERT INTO ArticulosOrdenes values
(2301,3786,'Red',3,35.00),
(2301,4011,'Raqueta',6,65.00),
(2301,9132,'Paq-3',4,4.75),
(2302,5794,'Paq-6',4,5.00),
(2303,4011,'Raqueta',2,65.00),
(2303,3141,'Funda',2,10.00)

SELECT * FROM OrdenesoRIGINAL
SELECT * FROM ORDENES
SELECT * FROM ArticulosOrdenes

-- 2NF y 3NF
CREATE TABLE Clientes(
id_cliente int,
nom_cliente char(20),
estado char(20))

INSERT INTO Clientes values
(101,'Martín','Caracas'),
(107,'Hernan','Coro'),
(110,'Pedro','Maracay')

CREATE TABLE Ordenes2NF
(id_orden int,
fecha date,
id_cliente int)

INSERT INTO Ordenes2NF values
(2301,'2011/02/23',101),
(2302,'2011/02/25',107),
(2303,'2011/02/27',110)

SELECT * FROM ORDENES2NF
SELECT * FROM Clientes
SELECT * FROM ArticulosOrdenes

CREATE TABLE Articulos(
num_art int,
nom_art char(20),
precio real)

INSERT INTO Articulos values
(3786,'Red',35.00),
(4011,'Raqueta',65.00),
(9132,'Paq-3',4.75),
(5794,'Paq-6',5.00),
(3141,'Funda',10.00)

CREATE TABLE ArticulosOrdenes3NF
(id_orden int,
num_art int,
cant int)

INSERT INTO ArticulosOrdenes3NF values
(2301,3786,3),
(2301,4011,6),
(2301,9132,4),
(2302,5794,4),
(2303,4011,2),
(2303,3141,2)

SELECT * FROM ORDENES2NF
SELECT * FROM Clientes
SELECT * FROM ArticulosOrdenes3NF
SELECT * FROM Articulos
