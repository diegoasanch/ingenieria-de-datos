IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Unidades') AND type in ('U'))
BEGIN
	CREATE TABLE Unidades
	(
		IdUnidad int NOT NULL,
		descripcion varchar(40) NULL,
		CONSTRAINT PK_Unidades PRIMARY KEY CLUSTERED (IdUnidad)
	) 
END
GO

INSERT INTO UNIDADES VALUES ( 1,'Caja X 6')
INSERT INTO UNIDADES VALUES ( 2,'Caja X 12')
INSERT INTO UNIDADES VALUES ( 3,'Caja X 24')
INSERT INTO UNIDADES VALUES ( 4,'Caja X 48')
INSERT INTO UNIDADES VALUES ( 5,'Bolsa 5 Krg')
INSERT INTO UNIDADES VALUES ( 6,'Bolsa 10 Krg')
INSERT INTO UNIDADES VALUES ( 7,'Bolsa 1 Krg')
INSERT INTO UNIDADES VALUES ( 8,'Paquete 1 Krg')
INSERT INTO UNIDADES VALUES ( 9,'Litro')
INSERT INTO UNIDADES VALUES ( 10,'Kilogramo')
INSERT INTO UNIDADES VALUES ( 11,'Gramo')
INSERT INTO UNIDADES VALUES ( 12,'Cent. Cub.')
INSERT INTO UNIDADES VALUES ( 13,'Botella')
INSERT INTO UNIDADES VALUES ( 14,'Lata')
INSERT INTO UNIDADES VALUES ( 15,'Cajon X 20 Kgs')
INSERT INTO UNIDADES VALUES ( 16,'Unidad')
INSERT INTO UNIDADES VALUES ( 17,'Docena')
INSERT INTO UNIDADES VALUES ( 18,'Lata X 5 Lts.')

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Rubros') AND type in ('U'))
BEGIN
	CREATE TABLE Rubros
	(
		IdRubro int NOT NULL,
		descripcion varchar(40) NULL,
		CONSTRAINT PK_Rubro PRIMARY KEY CLUSTERED (IdRubro)
	)
END
GO

Insert into Rubros values ( 1,'Entradas')
Insert into Rubros values ( 2,'Pescados')
Insert into Rubros values ( 3,'Carnes Blancas')
Insert into Rubros values ( 4,'Carnes Rojas')
Insert into Rubros values ( 5,'Pastas Caseras')
Insert into Rubros values ( 6,'Postres')
Insert into Rubros values ( 7,'Helados')
Insert into Rubros values ( 8,'Vinos Blancos')
Insert into Rubros values ( 9,'Vinos Tintos')
Insert into Rubros values ( 10,'Aperitivos y Licores')
Insert into Rubros values ( 11,'Cafeteria')

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Localidades') AND type in ('U'))
BEGIN
	CREATE TABLE Localidades
	(
		IdCodpos int NOT NULL,
		localida varchar(40) NULL,
		CONSTRAINT PK_Localida PRIMARY KEY CLUSTERED (IdCodpos)
	)
END
GO

Insert into Localidades values ( 1040,'Villa Adelina')
Insert into Localidades values ( 1141,'Parque Centenario')
Insert into Localidades values ( 1321,'Moreno')
Insert into Localidades values ( 1340,'Martinez')
Insert into Localidades values ( 1418,'Bernal')
Insert into Localidades values ( 1512,'Castelar')
Insert into Localidades values ( 1736,'Tigre')
Insert into Localidades values ( 6212,'La Plata')

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Sectores') AND type in ('U'))
BEGIN
	CREATE TABLE Sectores
	(
		IdSector int NOT NULL,
		descripcion varchar(40) NULL,
		CONSTRAINT PK_Sectores PRIMARY KEY CLUSTERED (IdSector)
	)
END
GO

Insert into Sectores values ( 1,'Salon Azul')
Insert into Sectores values ( 2,'Salon Central')
Insert into Sectores values ( 3,'Salon Madera')
Insert into Sectores values ( 4,'Sala de las Cortinas')
Insert into Sectores values ( 5,'Reservados')

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Mesas') AND type in ('U'))
BEGIN
	CREATE TABLE Mesas
	(
		IdMesa int NOT NULL,
		Descripcion varchar(40) NULL,
		IdSector int NULL,
		CONSTRAINT PK_Mesas PRIMARY KEY CLUSTERED (IdMesa),
		CONSTRAINT FK_Mesas_Sectores FOREIGN KEY(IdSector)
				   REFERENCES Sectores (IdSector)
	)
END
GO

Insert into Mesas values ( 1,'Mesa Redonda', 1)
Insert into Mesas values ( 2,'Mesa Redonda', 1)
Insert into Mesas values ( 3,'Rinconera', 1)
Insert into Mesas values ( 4,'Rinconera', 1)
Insert into Mesas values ( 5,'Reservado', 1)
Insert into Mesas values ( 6,'Mesa Redonda', 3)
Insert into Mesas values ( 7,'Mesa Redonda', 3)
Insert into Mesas values ( 8,'Rinconera', 3)
Insert into Mesas values ( 9,'Rinconera', 4)
Insert into Mesas values ( 10,'Reservado', 4)
Insert into Mesas values ( 11,'Mesa Redonda', 2)
Insert into Mesas values ( 12,'Mesa Redonda', 2)
Insert into Mesas values ( 13,'Rinconera', 3)
Insert into Mesas values ( 14,'Reservado Blanco', 5)
Insert into Mesas values ( 15,'Reservado Rosa', 5)
Insert into Mesas values ( 16,'Reservado Azul', 5)
Insert into Mesas values ( 17,'Reservado Verde', 5)
Insert into Mesas values ( 18,'Reservado Gris', 5)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Mozos') AND type in ('U'))
BEGIN
	CREATE TABLE Mozos
	(
		IdMozo int NOT NULL,
		nombre varchar(20) NULL,
		apellido varchar(20) NULL,
		calle varchar(40) NULL,
		numero int NULL,
		piso int NULL,
		departamento varchar(4) NULL,
		IdCodPos int NULL,
		CONSTRAINT PK_Mozos PRIMARY KEY CLUSTERED (IdMozo),
		CONSTRAINT FK_Mozos_Localidades FOREIGN KEY(IdCodPos)
				   REFERENCES Localidades (IdCodpos)
	)
END
GO

Insert into Mozos values ( 1,'Juan Carlos','Gonzalez','Quintana', null, 2311,' ', 1141)
Insert into Mozos values ( 2,'Ignacio ','Ramirez','Roca ', 3836,2,'C', 1340)
Insert into Mozos values ( 3,'Pablo ','Andrade','Cerrito ', 827,null,' ', 1321)
Insert into Mozos values ( 4,'Carolina ','Arce ','Castro ', 45,1,'F', 1040)
Insert into Mozos values ( 5,'Maria Belen','Zagala ','Rivadavia', 4563,null,' ', 1418)
Insert into Mozos values ( 6,'Romina ','Amarante','Mansilla', 2210,8,'A', 1512)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Ingredientes') AND type in ('U'))
BEGIN
	CREATE TABLE Ingredientes
	(
		IdIngrediente int NOT NULL,
		descripcion varchar(40) NULL,
		cUniCompra int NULL,
		cUniUso int NULL,
		precComp decimal(6, 2) NULL,
		precUso decimal(8, 6) NULL,
		stock decimal(8, 3) NULL,
		puntoRep decimal(8, 3) NULL,
		cantComp decimal(8, 3) NULL,
	    CONSTRAINT PK_Ingredientes PRIMARY KEY CLUSTERED (IdIngrediente),
		CONSTRAINT FK_Ingrediente_Unidad_De_Compra FOREIGN KEY(cUniCompra)
				   REFERENCES Unidades (IdUnidad),
	    CONSTRAINT FK_Ingrediente_Unidad_De_Uso FOREIGN KEY(cUniUso)
				   REFERENCES Unidades (IdUnidad)
	)
END
GO

Insert into Ingredientes values ( 116,'Gancia', 13, 12, 48, .048, 10, 6, 12)
Insert into Ingredientes values ( 201,'Colon Riesling', 1, 13, 36, 6, 20, 20, 6)
Insert into Ingredientes values ( 202,'Suter Etiqueta Marron', 1, 13, 48, 8, 22, 20, 6)
Insert into Ingredientes values ( 205,'Mont Fleuri', 1, 13, 48, 8, 24, 20, 6)
Insert into Ingredientes values ( 206,'Chateau Vieux', 1, 13, 36, 6, 30, 35, 6)
Insert into Ingredientes values ( 207,'San Felipe', 1, 13, 36, 6, 23, 30, 6)
Insert into Ingredientes values ( 208,'Bianchi Borgo¤a', 1, 13, 24, 4, 21, 44, 6)
Insert into Ingredientes values ( 209,'Clos du Moulin', 1, 13, 36, 6, 32, 23, 6)
Insert into Ingredientes values ( 210,'Comte du Valmont ', 1, 13, 48, 8, 41, 31, 6)
Insert into Ingredientes values ( 211,'Chateau Monchenot', 1, 13, 48, 8, 22, 33, 6)
Insert into Ingredientes values ( 212,'San Felipe', 1, 13, 24, 4, 42, 24, 6)
Insert into Ingredientes values ( 213,'Vintage', 1, 13, 24, 4, 21, 30, 6)
Insert into Ingredientes values ( 214,'Armaneuse', 1, 13, 36, 6, 12, 15, 6)
Insert into Ingredientes values ( 215,'Flitchman', 1, 13, 36, 6, 33, 24, 6)
Insert into Ingredientes values ( 217,'Tia Maria', 13, 12, 48, .048, 10, 6, 12)
Insert into Ingredientes values ( 218,'Contreau', 13, 12, 48, .048, 10, 6, 12)
Insert into Ingredientes values ( 219,'Jonny Walker Black', 13, 12, 120, .12, 5, 6, 6)
Insert into Ingredientes values ( 220,'Courvosier Napoleon', 13, 12, 240, .24, 1, 2, 1)
Insert into Ingredientes values ( 221,'Bianchi Chablis', 1, 13, 24, 4, 21, 44, 6)
Insert into Ingredientes values ( 222,'Hennesey V.S.O.P', 13, 12, 360, .36, 1, 2, 1)
Insert into Ingredientes values ( 230,'Trucha ', 3, 16, 80, 5, 50, 17, 48)
Insert into Ingredientes values ( 232,'Tomates ', 15, 11, 80, .004, 8000, 5000, 10000)
Insert into Ingredientes values ( 233,'Langostinos ', 5, 11, 200, .004, 2000, 1000, 3000)
Insert into Ingredientes values ( 234,'Champingones ', 10, 11, 20, .002, 2000, 1500, 3000)
Insert into Ingredientes values ( 235,'Kanikama ', 10, 11, 80, .08, 2000, 1000, 1500)
Insert into Ingredientes values ( 236,'Queso Rallado ', 10, 11, 30, .03, 500, 1500, 4000)
Insert into Ingredientes values ( 237,'Jamon de Ciervo ', 10, 11, 120, .12, 5000, 1000, 7000)
Insert into Ingredientes values ( 238,'Alcaparras ', 10, 11, 60, .06, 1000, 400, 1000)
Insert into Ingredientes values ( 239,'Limon ', 6, 11, 70, .007, 15000, 4000, 10000)
Insert into Ingredientes values ( 241,'Manteca ', 8, 11, 20, .02, 1500, 3000, 4000)
Insert into Ingredientes values ( 242,'Salmon ', 2, 16, 80, 6.64, 30, 19, 48)
Insert into Ingredientes values ( 243,'Crema ', 9, 12, 6, .006, 12000, 10000, 10000)
Insert into Ingredientes values ( 244,'Pollo ', 10, 11, 10, .01, 15000, 17000, 40000)
Insert into Ingredientes values ( 245,'Pavo ', 16, 11, 140, .014, 10000, 10000, 10000)
Insert into Ingredientes values ( 246,'Cebolla ', 6, 11, 30, .003, 25000, 15000, 20000)
Insert into Ingredientes values ( 247,'Cebolla de Verdeo ', 5, 11, 40, .008, 4300, 5000, 10000)
Insert into Ingredientes values ( 248,'Lomo ', 10, 11, 26, .026, 4300, 9000, 15000)
Insert into Ingredientes values ( 251,'Marsalla ', 13, 12, 8, .008, 1000, 2000, 5000)
Insert into Ingredientes values ( 252,'Carre de Cerdo ', 10, 11, 22, .022, 2300, 5000, 10000)
Insert into Ingredientes values ( 253,'Cerezas ', 8, 11, 24, .0024, 2000, 1000, 2000)
Insert into Ingredientes values ( 254,'Fetuccini ', 8, 11, 8, .008, 3000, 4000, 5000)
Insert into Ingredientes values ( 255,'Tagliatelli ', 8, 11, 10, .01, 4500, 4000, 5000)
Insert into Ingredientes values ( 256,'Ravioles ', 8, 11, 10, .01, 4000, 4000, 5000)
Insert into Ingredientes values ( 257,'Ficcile ', 8, 11, 8, .008, 2500, 4000, 5000)
Insert into Ingredientes values ( 258,'Sorrentinos ', 8, 11, 12, .012, 1500, 4000, 5000)
Insert into Ingredientes values ( 265,'Frutillas ', 5, 11, 8, .008, 2800, 3000, 4000)
Insert into Ingredientes values ( 267,'Biscochuelo ', 16, 11, 16, .016, 4000, 2000, 4000)
Insert into Ingredientes values ( 268,'Bananas ', 17, 16, 8, .66, 36, 12, 24)
Insert into Ingredientes values ( 269,'Dulce de Leche ', 10, 11, 14, .014, 2000, 1700, 3000)
Insert into Ingredientes values ( 270,'Helado Americana ', 18, 12, 60, .012, 3100, 2000, 3000)
Insert into Ingredientes values ( 271,'Helado Chocolate ', 18, 12, 60, .012, 2700, 2000, 3000)
Insert into Ingredientes values ( 272,'Helado Frutilla ', 18, 12, 60, .012, 1700, 2000, 3000)
Insert into Ingredientes values ( 273,'Almendrado ', 4, 16, 120, 2.4, 50, 30, 40)
Insert into Ingredientes values ( 274,'Salsa de Chocolate ', 14, 12, 12, .012, 1200, 1000, 1000)
Insert into Ingredientes values ( 275,'Enalada de Frutas ', 10, 11, 12, .012, 1000, 3000, 4000)
Insert into Ingredientes values ( 276,'Obleas ', 8, 16, 16, .16, 50, 30, 100)
Insert into Ingredientes values ( 277,'Huevos ', 17, 16, 10, .83, 48, 96, 144)
Insert into Ingredientes values ( 300,'Cafe en Granos ', 5, 11, 160, .032, 8000, 10000, 10000)
Insert into Ingredientes values ( 301,'Leche ', 9, 12, 2, .002, 6, 5, 5)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Platos') AND type in ('U'))
BEGIN
	CREATE TABLE Platos
	(
		IdPlato int NOT NULL,
		descripcion varchar(25) NULL,
		precio decimal(5, 2) NULL,
		IdRubro int NULL,
		CONSTRAINT PK_Platos PRIMARY KEY CLUSTERED (IdPlato),
		CONSTRAINT FK_Platos_Rubros FOREIGN KEY(IdRubro)
				   REFERENCES Rubros (IdRubro)
	)
END
GO

Insert into Platos values ( 100,'Tomates Rellenos', 6.5, 1)
Insert into Platos values ( 101,'Copa de Langostinos', 12, 1)
Insert into Platos values ( 102,'Carpaccio', 8, 1)
Insert into Platos values ( 103,'Kanikama', 6, 1)
Insert into Platos values ( 104,'Jamon de Ciervo', 10, 1)
Insert into Platos values ( 202,'Trucha a la Manteca Negra', 15, 2)
Insert into Platos values ( 203,'Salmon a la Crema', 11, 2)
Insert into Platos values ( 204,'Salmon a la Parrilla', 9, 2)
Insert into Platos values ( 302,'Pollo a la Parrilla', 6, 3)
Insert into Platos values ( 303,'Pavo Relleno', 11, 3)
Insert into Platos values ( 304,'Pollo al Estragon', 9, 3)
Insert into Platos values ( 305,'Pollo al Champignon', 9, 3)
Insert into Platos values ( 402,'Lomo a la Pimienta', 8, 4)
Insert into Platos values ( 403,'Lomo al Marsalla', 8, 4)
Insert into Platos values ( 404,'Lomo al Champignon', 9, 4)
Insert into Platos values ( 405,'Carre con Cerezas', 13, 4)
Insert into Platos values ( 406,'Lomo Strogonoff', 12, 4)
Insert into Platos values ( 502,'Fetuccini', 6, 5)
Insert into Platos values ( 503,'Tagliatteli', 7, 5)
Insert into Platos values ( 504,'Ravioles', 6, 5)
Insert into Platos values ( 505,'Fuccile', 7, 5)
Insert into Platos values ( 506,'Sorrentinos', 7, 5)
Insert into Platos values ( 600,'Frutillas con Crema', 4.5, 6)
Insert into Platos values ( 601,'Tiramisu', 6, 6)
Insert into Platos values ( 602,'Banana Split', 8, 6)
Insert into Platos values ( 603,'Macedonia de Frutas', 3.5, 6)
Insert into Platos values ( 604,'Peras al Borgo¤a', 9, 6)
Insert into Platos values ( 700,'Helado tres sabores', 6, 7)
Insert into Platos values ( 701,'Almendrado', 6, 7)
Insert into Platos values ( 702,'Charlotte', 7, 7)
Insert into Platos values ( 703,'Copa Melba', 9, 8)
Insert into Platos values ( 704,'Copa Falfala', 15, 9)
Insert into Platos values ( 800,'Bianchi Chablis ', 6, 8)
Insert into Platos values ( 801,'Colon Riesling', 9, 8)
Insert into Platos values ( 802,'Suter Etiqueta Marron', 12, 8)
Insert into Platos values ( 803,'Chateau Monchenot', 15, 8)
Insert into Platos values ( 805,'Mont Fleuri', 9, 8)
Insert into Platos values ( 806,'Chateau Vieux', 12, 8)
Insert into Platos values ( 807,'San Felipe', 7, 8)
Insert into Platos values ( 900,'Bianchi Borgo¤a', 6, 9)
Insert into Platos values ( 901,'Clos du Moulin', 10, 9)
Insert into Platos values ( 902,'Comte du Valmont ', 12, 9)
Insert into Platos values ( 903,'Chateau Monchenot', 15, 9)
Insert into Platos values ( 904,'San Felipe', 7, 9)
Insert into Platos values ( 905,'Vintage', 10, 9)
Insert into Platos values ( 906,'Armaneuse', 15, 9)
Insert into Platos values ( 907,'Flitchman', 14, 9)
Insert into Platos values ( 1000,'Gancia', 3, 10)
Insert into Platos values ( 1001,'Tia Maria', 4, 10)
Insert into Platos values ( 1002,'Contreau', 4, 10)
Insert into Platos values ( 1003,'Jonny Walker Black', 7, 10)
Insert into Platos values ( 1004,'Courvosier Napoleon', 8, 10)
Insert into Platos values ( 1005,'Hennesey V.S.O.P', 15, 10)
Insert into Platos values ( 1108,'Cafe', 1.5, 11)
Insert into Platos values ( 1121,'Te / Te digestivo', 1, 11)
Insert into Platos values ( 1133,'Capuccino', 2.5, 11)
Insert into Platos values ( 1180,'Cortado', 1.5, 11)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Facturas') AND type in ('U'))
BEGIN
	CREATE TABLE Facturas
	(
		NroFactura int NOT NULL,
		IdMesa int NOT NULL,
		IdMozo int NOT NULL,
		cantidadPersonas int null,
		total decimal(6, 2) NULL,
		fechaApertura datetime NULL,
		horaApertuta datetime NULL,
		fechaCierre datetime null,
		horaCierre datetime null,
		CONSTRAINT PK_Facturas PRIMARY KEY CLUSTERED (NroFactura),
		CONSTRAINT FK_Facturas_Mesas FOREIGN KEY(IdMesa)
				   REFERENCES Mesas (IdMesa),
		CONSTRAINT FK_Facturas_Mozos FOREIGN KEY(IdMozo)
				   REFERENCES Mozos (IdMozo)
	)
END
GO
set dateformat 'dmy'

Insert into Facturas values ( 1, 1, 3,2, 165,'15/01/2009','22:12:00','15/01/2009',null)
Insert into Facturas values ( 2, 3, 4,2,  34,'15/01/2009','22:30:00','15/01/2009',null)
Insert into Facturas values ( 3, 4, 3,2,  62,'15/01/2009','22:31:00','15/01/2009',null)
Insert into Facturas values ( 4, 3, 2,2,  98,'15/01/2009','21:12:00','15/01/2009',null)
Insert into Facturas values ( 5, 7, 1,2,  24,'25/01/2009','23:00:00','25/01/2009',null)
Insert into Facturas values ( 6, 6, 4,2,  86,'25/01/2009','22:15:00','25/01/2009',null)
Insert into Facturas values ( 7, 9, 5,2,  18,'25/01/2009','23:05:00','25/01/2009',null)
Insert into Facturas values ( 8, 2, 3,2, 154,'25/01/2009','21:44:00','25/01/2009',null)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('Proveedores') AND type in ('U'))
BEGIN
	CREATE TABLE Proveedores
	(
		IdProveedor int NOT NULL,
		razsoc varchar(40) NULL,
		calle varchar(40) NULL,
		numero int NULL,
		piso int NULL,
		departamento varchar(4) NULL,
		IdCodPos int NULL,
		CONSTRAINT PK_Proveed PRIMARY KEY CLUSTERED (IdProveedor),
		CONSTRAINT FK_Proveedores_Localidades FOREIGN KEY(IdCodPos)
				   REFERENCES Localidades (IdCodpos)
	)
END
GO

Insert into Proveedores values ( 10,'La Rural S.A. ','Rivadavia', 1310, 1,'G', 1141)
Insert into Proveedores values ( 20,'San Ignacio ','Ramirez ', 836, 0,'', 1340)
Insert into Proveedores values ( 30,'Frig. Peualla ','Andrade ', 1827, 5,'T', 1321)
Insert into Proveedores values ( 40,'Santander SRL ','Arce ', 245, 0,' ', 1040)
Insert into Proveedores values ( 50,'Las Marias ','Zagala ', 463, 10,'H', 1418)
Insert into Proveedores values ( 60,'Granja Amor ','Amarante ', 103, 0,' ', 1512)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ItemsFactura') AND type in ('U'))
BEGIN
	CREATE TABLE ItemsFactura
	(
		NroFactura int NOT NULL,
		IdPlato int NOT NULL,
		cantida int NULL,
		precio decimal(6, 2) NULL,
		CONSTRAINT PK_ItemsFactura PRIMARY KEY CLUSTERED (NroFactura, IdPlato),
		CONSTRAINT FK_ItemsFactura_Facturas FOREIGN KEY(NroFactura)
				   REFERENCES Facturas (NroFactura),
		CONSTRAINT FK_ItemsFactura_Platos FOREIGN KEY(IdPlato)
				   REFERENCES Platos (IdPlato)
	)
END
GO

Insert into ItemsFactura values ( 1, 100, 1, 13)
Insert into ItemsFactura values ( 1, 102, 1, 24)
Insert into ItemsFactura values ( 1, 402, 1, 16)
Insert into ItemsFactura values ( 1, 406, 1, 24)
Insert into ItemsFactura values ( 1, 702, 2, 14)
Insert into ItemsFactura values ( 1, 803, 1, 30)
Insert into ItemsFactura values ( 1, 1005, 1, 30)
Insert into ItemsFactura values ( 2, 1003, 2, 14)
Insert into ItemsFactura values ( 2, 1108, 2, 3)
Insert into ItemsFactura values ( 3, 303, 1, 22)
Insert into ItemsFactura values ( 3, 502, 1, 12)
Insert into ItemsFactura values ( 3, 603, 2, 7)
Insert into ItemsFactura values ( 3, 807, 1, 14)
Insert into ItemsFactura values ( 4, 1000, 3, 6)
Insert into ItemsFactura values ( 4, 1001, 2, 8)
Insert into ItemsFactura values ( 4, 1003, 4, 16)
Insert into ItemsFactura values ( 5, 1108, 8, 3)
Insert into ItemsFactura values ( 6, 403, 2, 16)
Insert into ItemsFactura values ( 6, 601, 2, 12)
Insert into ItemsFactura values ( 6, 803, 1, 30)
Insert into ItemsFactura values ( 7, 801, 1, 18)
Insert into ItemsFactura values ( 8, 104, 2, 20)
Insert into ItemsFactura values ( 8, 404, 1, 18)
Insert into ItemsFactura values ( 8, 405, 1, 26)
Insert into ItemsFactura values ( 8, 704, 1, 30)
Insert into ItemsFactura values ( 8, 905, 2, 20)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('PlaIng') AND type in ('U'))
BEGIN
	CREATE TABLE PlaIng
	(
		IdPlato int NOT NULL,
		IdIngrediente int NOT NULL,
		cantida decimal(6, 3) NULL,
	    CONSTRAINT PK_PlaIng PRIMARY KEY CLUSTERED (IdPlato, IdIngrediente),
		CONSTRAINT FK_PlaIng_Ingredientes FOREIGN KEY(IdIngrediente)
				   REFERENCES Ingredientes (IdIngrediente),
		CONSTRAINT FK_PlaIng_Platos FOREIGN KEY(IdPlato)
				   REFERENCES Platos (IdPlato)
	)
END
GO

Insert into PlaIng values ( 100, 232, 200)
Insert into PlaIng values ( 100, 239, 20)
Insert into PlaIng values ( 100, 241, 50)
Insert into PlaIng values ( 100, 246, 100)
Insert into PlaIng values ( 101, 233, 200)
Insert into PlaIng values ( 101, 239, 60)
Insert into PlaIng values ( 102, 236, 60)
Insert into PlaIng values ( 102, 238, 20)
Insert into PlaIng values ( 102, 239, 60)
Insert into PlaIng values ( 102, 248, 200)
Insert into PlaIng values ( 103, 235, 200)
Insert into PlaIng values ( 103, 239, 60)
Insert into PlaIng values ( 104, 237, 200)
Insert into PlaIng values ( 202, 230, 1)
Insert into PlaIng values ( 202, 241, 200)
Insert into PlaIng values ( 203, 242, 1)
Insert into PlaIng values ( 203, 243, 200)
Insert into PlaIng values ( 204, 239, 60)
Insert into PlaIng values ( 204, 242, 1)
Insert into PlaIng values ( 302, 239, 60)
Insert into PlaIng values ( 302, 244, 500)
Insert into PlaIng values ( 303, 234, 50)
Insert into PlaIng values ( 303, 243, 100)
Insert into PlaIng values ( 303, 245, 400)
Insert into PlaIng values ( 303, 247, 100)
Insert into PlaIng values ( 303, 277, 1)
Insert into PlaIng values ( 304, 236, 50)
Insert into PlaIng values ( 304, 243, 100)
Insert into PlaIng values ( 304, 244, 400)
Insert into PlaIng values ( 305, 234, 100)
Insert into PlaIng values ( 305, 244, 400)
Insert into PlaIng values ( 402, 243, 100)
Insert into PlaIng values ( 402, 248, 250)
Insert into PlaIng values ( 403, 248, 250)
Insert into PlaIng values ( 403, 251, 150)
Insert into PlaIng values ( 404, 234, 100)
Insert into PlaIng values ( 404, 248, 259)
Insert into PlaIng values ( 405, 238, 50)
Insert into PlaIng values ( 405, 252, 300)
Insert into PlaIng values ( 405, 253, 100)
Insert into PlaIng values ( 406, 234, 100)
Insert into PlaIng values ( 406, 243, 150)
Insert into PlaIng values ( 406, 246, 100)
Insert into PlaIng values ( 406, 248, 250)
Insert into PlaIng values ( 502, 236, 50)
Insert into PlaIng values ( 502, 254, 200)
Insert into PlaIng values ( 503, 236, 50)
Insert into PlaIng values ( 503, 255, 300)
Insert into PlaIng values ( 504, 236, 50)
Insert into PlaIng values ( 504, 256, 300)
Insert into PlaIng values ( 505, 236, 50)
Insert into PlaIng values ( 505, 257, 300)
Insert into PlaIng values ( 506, 236, 50)
Insert into PlaIng values ( 506, 257, 300)
Insert into PlaIng values ( 600, 243, 100)
Insert into PlaIng values ( 600, 265, 200)
Insert into PlaIng values ( 601, 243, 100)
Insert into PlaIng values ( 601, 267, 150)
Insert into PlaIng values ( 601, 269, 80)
Insert into PlaIng values ( 601, 274, 50)
Insert into PlaIng values ( 602, 243, 100)
Insert into PlaIng values ( 602, 268, 2)
Insert into PlaIng values ( 602, 269, 100)
Insert into PlaIng values ( 603, 275, 300)
Insert into PlaIng values ( 700, 270, 100)
Insert into PlaIng values ( 700, 271, 100)
--Insert into PlaIng values ( 700, 272, 100)
Insert into PlaIng values ( 701, 273, 1)
Insert into PlaIng values ( 702, 273, 1)
Insert into PlaIng values ( 702, 274, 100)
Insert into PlaIng values ( 703, 243, 80)
Insert into PlaIng values ( 703, 270, 100)
Insert into PlaIng values ( 703, 275, 100)
Insert into PlaIng values ( 703, 276, 4)
Insert into PlaIng values ( 704, 243, 100)
Insert into PlaIng values ( 704, 253, 50)
Insert into PlaIng values ( 704, 270, 50)
Insert into PlaIng values ( 704, 271, 50)
Insert into PlaIng values ( 704, 272, 50)
Insert into PlaIng values ( 704, 274, 50)
Insert into PlaIng values ( 704, 276, 4)
Insert into PlaIng values ( 800, 221, 1)
Insert into PlaIng values ( 801, 201, 1)
Insert into PlaIng values ( 802, 202, 1)
Insert into PlaIng values ( 803, 211, 1)
Insert into PlaIng values ( 805, 205, 1)
Insert into PlaIng values ( 806, 206, 1)
Insert into PlaIng values ( 807, 207, 1)
Insert into PlaIng values ( 900, 208, 1)
Insert into PlaIng values ( 901, 209, 1)
Insert into PlaIng values ( 902, 210, 1)
Insert into PlaIng values ( 903, 211, 1)
Insert into PlaIng values ( 904, 212, 1)
Insert into PlaIng values ( 905, 213, 1)
Insert into PlaIng values ( 906, 214, 1)
Insert into PlaIng values ( 907, 215, 1)
Insert into PlaIng values ( 1000, 116, 150)
Insert into PlaIng values ( 1001, 217, 60)
Insert into PlaIng values ( 1002, 218, 60)
Insert into PlaIng values ( 1003, 219, 40)
Insert into PlaIng values ( 1004, 220, 40)
Insert into PlaIng values ( 1005, 222, 40)
Insert into PlaIng values ( 1108, 300, 15)
Insert into PlaIng values ( 1121, 301, 5)
Insert into PlaIng values ( 1133, 300, 15)
Insert into PlaIng values ( 1133, 301, 20)
Insert into PlaIng values ( 1180, 300, 15)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('TelefonoMozo') AND type in ('U'))
BEGIN
	CREATE TABLE TelefonoMozo
	(
		IdTelefono int NOT NULL,
		IdMozo int NOT NULL,
		codArea int NULL,
		central int NULL,
		numero int NULL,
		celular int NULL,
		CONSTRAINT PK_TelefonoMozo PRIMARY KEY CLUSTERED (IdTelefono),
		CONSTRAINT FK_TelefonoMozo_Mozos FOREIGN KEY(IdMozo)
				   REFERENCES Mozos (IdMozo)
	)

END
GO

Insert into TelefonoMozo values ( 1, 6, 11, 4438, 4471,null)
Insert into TelefonoMozo values ( 2, 3, 11, 4237, 9879,15)
Insert into TelefonoMozo values ( 3, 4, 11, 5411, 3343,null)
Insert into TelefonoMozo values ( 4, 5, 11, 4432, 9876,15)
Insert into TelefonoMozo values ( 5, 3, 11, 4832, 1808,null)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ProIng') AND type in ('U'))
BEGIN
	CREATE TABLE ProIng
	(
		IdIngrediente int NOT NULL,
		IdProveedor int NOT NULL,
		factor decimal(6, 3) NULL,
		fechComp datetime NOT NULL,
		CONSTRAINT PK_ProIng PRIMARY KEY CLUSTERED (IdIngrediente, IdProveedor, fechComp),
		CONSTRAINT FK_ProIng_Ingredientes FOREIGN KEY(IdIngrediente)
				   REFERENCES Ingredientes (IdIngrediente),
		CONSTRAINT FK_ProIng_Proveedores FOREIGN KEY(IdProveedor)
				   REFERENCES Proveedores (IdProveedor)
	)
END
GO

Insert into ProIng values ( 116, 10, .001,'01/01/1900')
Insert into ProIng values ( 116, 10, .001,'02/05/2009')
Insert into ProIng values ( 201, 10, 6,'01/01/1900')
Insert into ProIng values ( 202, 10, 6,'01/01/1900')
Insert into ProIng values ( 205, 10, 6,'01/01/1900')
Insert into ProIng values ( 206, 20, 6,'01/01/1900')
Insert into ProIng values ( 207, 20, 6,'01/01/1900')
Insert into ProIng values ( 208, 20, 6,'01/01/1900')
Insert into ProIng values ( 209, 10, 6,'01/01/1900')
Insert into ProIng values ( 210, 10, 6,'01/01/1900')
Insert into ProIng values ( 211, 20, 6,'01/01/1900')
Insert into ProIng values ( 212, 10, 6,'01/01/1900')
Insert into ProIng values ( 213, 20, 6,'01/01/1900')
Insert into ProIng values ( 214, 20, 6,'01/01/1900')
Insert into ProIng values ( 215, 10, .001,'01/01/1900')
Insert into ProIng values ( 215, 10, .001,'02/05/2009')
Insert into ProIng values ( 217, 10, .001,'01/01/1900')
Insert into ProIng values ( 217, 10, .001,'02/05/2009')
Insert into ProIng values ( 218, 10, .001,'01/01/1900')
Insert into ProIng values ( 218, 10, .001,'02/05/2009')
Insert into ProIng values ( 219, 20, .001,'01/01/1900')
Insert into ProIng values ( 219, 20, .001,'02/05/2009')
Insert into ProIng values ( 220, 20, .001,'01/01/1900')
Insert into ProIng values ( 222, 20, .001,'01/01/1900')
Insert into ProIng values ( 230, 30, .063,'01/01/1900')
Insert into ProIng values ( 230, 40, .001,'01/01/1900')
Insert into ProIng values ( 232, 50, 0,'01/01/1900')
Insert into ProIng values ( 232, 50, 0,'01/11/2009')
Insert into ProIng values ( 232, 60, .001,'01/01/1900')
Insert into ProIng values ( 232, 60, .001,'01/01/2009')
Insert into ProIng values ( 233, 30, 0,'01/01/1900')
Insert into ProIng values ( 233, 40, .001,'01/01/1900')
Insert into ProIng values ( 234, 50, .001,'01/01/1900')
Insert into ProIng values ( 234, 50, .001,'01/11/2009')
Insert into ProIng values ( 234, 60, .001,'01/01/1900')
Insert into ProIng values ( 234, 60, .001,'02/01/2009')
Insert into ProIng values ( 235, 30, .001,'01/01/1900')
Insert into ProIng values ( 235, 40, .001,'01/01/1900')
Insert into ProIng values ( 236, 50, .001,'01/01/1900')
Insert into ProIng values ( 236, 60, .001,'01/01/1900')
Insert into ProIng values ( 237, 30, .001,'01/01/1900')
Insert into ProIng values ( 237, 50, .001,'01/01/1900')
Insert into ProIng values ( 238, 50, .001,'01/01/1900')
Insert into ProIng values ( 238, 50, .001,'01/07/2009')
Insert into ProIng values ( 238, 60, .001,'01/01/1900')
Insert into ProIng values ( 238, 60, .001,'02/01/2009')
Insert into ProIng values ( 239, 50, 0,'01/01/1900')
Insert into ProIng values ( 239, 60, .001,'01/01/1900')
Insert into ProIng values ( 239, 60, .001,'02/01/2009')
Insert into ProIng values ( 241, 50, .001,'01/01/1900')
Insert into ProIng values ( 241, 60, .001,'01/01/1900')
Insert into ProIng values ( 242, 30, .083,'01/01/1900')
Insert into ProIng values ( 242, 40, .001,'01/01/1900')
Insert into ProIng values ( 243, 50, .001,'01/01/1900')
Insert into ProIng values ( 243, 60, .001,'01/01/1900')
Insert into ProIng values ( 244, 30, .001,'01/01/1900')
Insert into ProIng values ( 244, 30, .001,'03/07/2009')
Insert into ProIng values ( 244, 60, .001,'01/01/1900')
Insert into ProIng values ( 245, 30, 0,'01/01/1900')
Insert into ProIng values ( 245, 60, .001,'01/01/1900')
Insert into ProIng values ( 246, 50, 0,'01/01/1900')
Insert into ProIng values ( 246, 60, .001,'01/01/1900')
Insert into ProIng values ( 246, 60, .001,'02/01/2009')
Insert into ProIng values ( 247, 50, 0,'01/01/1900')
Insert into ProIng values ( 247, 60, .001,'01/01/1900')
Insert into ProIng values ( 247, 60, .001,'02/01/2009')
Insert into ProIng values ( 248, 30, .001,'01/01/1900')
Insert into ProIng values ( 248, 50, .001,'01/01/1900')
Insert into ProIng values ( 251, 10, .001,'01/01/1900')
Insert into ProIng values ( 251, 10, .001,'02/07/2009')
Insert into ProIng values ( 251, 50, .001,'01/01/1900')
Insert into ProIng values ( 252, 30, .001,'01/01/1900')
Insert into ProIng values ( 252, 50, .001,'01/01/1900')
Insert into ProIng values ( 253, 50, .001,'01/01/1900')
Insert into ProIng values ( 253, 50, .001,'03/07/2009')
Insert into ProIng values ( 253, 60, .001,'01/01/1900')
Insert into ProIng values ( 254, 40, .001,'01/01/1900')
Insert into ProIng values ( 254, 40, .001,'03/07/2009')
Insert into ProIng values ( 254, 50, .001,'01/01/1900')
Insert into ProIng values ( 255, 40, .001,'01/01/1900')
Insert into ProIng values ( 255, 50, .001,'01/01/1900')
Insert into ProIng values ( 256, 40, .001,'01/01/1900')
Insert into ProIng values ( 256, 50, .001,'01/01/1900')
Insert into ProIng values ( 257, 40, .001,'01/01/1900')
Insert into ProIng values ( 257, 50, .001,'01/01/1900')
Insert into ProIng values ( 258, 40, .001,'01/01/1900')
Insert into ProIng values ( 258, 40, .001,'02/07/2009')
Insert into ProIng values ( 258, 50, .001,'01/01/1900')
Insert into ProIng values ( 258, 50, .001,'02/07/2009')
Insert into ProIng values ( 265, 50, 0,'01/01/1900')
Insert into ProIng values ( 265, 60, .001,'01/01/1900')
Insert into ProIng values ( 265, 60, .001,'02/01/2009')
Insert into ProIng values ( 267, 40, .001,'01/01/1900')
Insert into ProIng values ( 267, 40, .001,'03/07/2009')
Insert into ProIng values ( 267, 60, 0,'01/01/1900')
Insert into ProIng values ( 267, 60, 0,'03/07/2009')
Insert into ProIng values ( 268, 50, .083,'01/01/1900')
Insert into ProIng values ( 268, 50, .083,'01/07/2009')
Insert into ProIng values ( 268, 60, .001,'01/01/1900')
Insert into ProIng values ( 268, 60, .001,'04/01/2009')
Insert into ProIng values ( 269, 40, .001,'01/01/1900')
Insert into ProIng values ( 269, 40, .001,'03/07/2009')
Insert into ProIng values ( 269, 60, .001,'01/01/1900')
Insert into ProIng values ( 269, 60, .001,'01/07/2009')
Insert into ProIng values ( 270, 40, .001,'01/01/1900')
Insert into ProIng values ( 270, 60, 0,'01/01/1900')
Insert into ProIng values ( 271, 40, .001,'01/01/1900')
Insert into ProIng values ( 271, 60, 0,'01/01/1900')
Insert into ProIng values ( 272, 40, .001,'01/01/1900')
Insert into ProIng values ( 272, 60, 0,'01/01/1900')
Insert into ProIng values ( 273, 40, .001,'01/01/1900')
Insert into ProIng values ( 273, 60, .02,'01/01/1900')
Insert into ProIng values ( 274, 40, .001,'01/01/1900')
Insert into ProIng values ( 274, 60, .001,'01/01/1900')
Insert into ProIng values ( 275, 40, .001,'01/01/1900')
Insert into ProIng values ( 275, 60, .001,'01/01/1900')
Insert into ProIng values ( 276, 40, .001,'01/01/1900')
Insert into ProIng values ( 276, 60, .01,'01/01/1900')
Insert into ProIng values ( 277, 50, .083,'01/01/1900')
Insert into ProIng values ( 277, 60, .083,'01/01/1900')

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('TelefonoProveedor') AND type in ('U'))
BEGIN
	CREATE TABLE TelefonoProveedor
	(
		IdTelefono int NOT NULL,
		IdProveedor int NOT NULL,
		codArea int NULL,
		central int NULL,
		numero int NULL,
		CONSTRAINT PK_TelefonoProveedor PRIMARY KEY CLUSTERED (IdTelefono),
		CONSTRAINT FK_TelefonoProveedor_Proveedores FOREIGN KEY(IdProveedor)
				   REFERENCES Proveedores (IdProveedor)
	)
END
GO

Insert into TelefonoProveedor values ( 1, 10, 64, 34, 2231)
Insert into TelefonoProveedor values ( 2, 10, 64, 34, 2232)
Insert into TelefonoProveedor values ( 3, 20, 1, 342, 2136)
Insert into TelefonoProveedor values ( 4, 20, 1, 342, 6771)
Insert into TelefonoProveedor values ( 5, 30, 1, 540, 2536)
Insert into TelefonoProveedor values ( 6, 40, 1, 977, 4563)
Insert into TelefonoProveedor values ( 7, 40, 1, 977, 7865)
Insert into TelefonoProveedor values ( 8, 40, 1, 977, 2784)
Insert into TelefonoProveedor values ( 9, 50, 1, 442, 2456)
Insert into TelefonoProveedor values ( 10, 60, 1, 332, 9398)
Insert into TelefonoProveedor values ( 11, 60, 1, 332, 9785)

