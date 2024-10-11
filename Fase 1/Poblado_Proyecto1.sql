-- POBLADO DE DATOS

-- EXEC POBLADO_PROYECTO1
-- DROP PROCEDURE POBLADO_PROYECTO1

CREATE PROCEDURE POBLADO_PROYECTO1
AS
BEGIN

	-- Limpiado de tablas
	DELETE El_Ajedrecista.dbo.FactCotizacion;
	DELETE El_Ajedrecista.dbo.FactFacturacion;
	DELETE El_Ajedrecista.dbo.DimSubCot;
	DELETE El_Ajedrecista.dbo.DimSubFact;
	DELETE El_Ajedrecista.dbo.DimArticulo;
	DELETE El_Ajedrecista.dbo.DimCliente;
	DELETE El_Ajedrecista.dbo.DimCondicionPago;
	DELETE El_Ajedrecista.dbo.DimEmbarque;
	DELETE El_Ajedrecista.dbo.DimMoneda;
	DELETE El_Ajedrecista.dbo.DimTime;
	DELETE El_Ajedrecista.dbo.DimVendedor;

	--Poblar DimSubCot
	INSERT INTO El_Ajedrecista.dbo.DimSubCot
	SELECT DISTINCT Folio
	FROM AutopartesP2024.dbo.CotVtaEncabezado;

	--Poblar DimSubFact
	INSERT INTO El_Ajedrecista.dbo.DimSubFact
	SELECT DISTINCT Folio
	FROM AutopartesP2024.dbo.FacturaEncabezado;

	--Poblar DimArticulo
	INSERT INTO El_Ajedrecista.dbo.DimArticulo
	SELECT 
		DISTINCT a.clave,
		a.Descripcion,
		ISNULL(ag.Descripcion, 'NA'),
		ISNULL(ap.Descripcion, 'NA'),
		ISNULL(ac.Descripcion, 'NA')
	FROM AutopartesP2024.dbo.Articulo as a
	LEFT JOIN AutopartesP2024.dbo.ArticuloClase as ac ON a.ArticuloClase = ac.Clave
	LEFT JOIN AutopartesP2024.dbo.ArticuloGrupo as ag ON a.ArticuloGrupo = ag.Clave
	LEFT JOIN AutopartesP2024.dbo.ArticuloTipo as ap ON a.ArticuloTipo = ap.Clave;

	--Poblar DimCliente
	INSERT INTO El_Ajedrecista.dbo.DimCliente
	SELECT 
		DISTINCT c.Clave,
		ISNULL(ct.Descripcion, 'NA')
	FROM AutopartesP2024.dbo.Cliente as c
	LEFT JOIN AutopartesP2024.dbo.ClienteTipo as ct ON c.ClienteTipo = ct.Clave;

	--Poblar DimCondicionPago
	INSERT INTO El_Ajedrecista.dbo.DimCondicionPago
	SELECT 
		DISTINCT Clave,
		Descripcion
	FROM AutopartesP2024.dbo.CondicionPago;

	--Poblar DimEmbarque
	INSERT INTO El_Ajedrecista.dbo.DimEmbarque
	SELECT 
		DISTINCT Clave,
		Descripcion
	FROM AutopartesP2024.dbo.MedioEmbarque
	UNION
	SELECT 'NA', 'NA';

	--Poblar DimMoneda
	INSERT INTO El_Ajedrecista.dbo.DimMoneda
	SELECT 
		DISTINCT Clave,
		Descripcion,
		Tipo
	FROM AutopartesP2024.dbo.Moneda;

	--Poblar DimVendedor
	INSERT INTO El_Ajedrecista.dbo.DimVendedor
	SELECT 
		DISTINCT Clave,
		Nombre
	FROM AutopartesP2024.dbo.Vendedor;

	--Poblar DimTime
	INSERT INTO El_Ajedrecista.dbo.DimTime
	SELECT 
		DISTINCT CAST(CONVERT(varchar(8), cv.Fecha, 112) AS INT), 
		YEAR(cv.Fecha),
		CAST((MONTH(cv.Fecha) - 1)/6 AS INT) + 1,
		CAST((MONTH(cv.Fecha) - 1)/3 AS INT) + 1,
		MONTH(cv.Fecha),
		DAY(cv.Fecha),
		CASE DATEPART(WEEKDAY, cv.Fecha)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miércoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sábado'
		END AS Weekday
		FROM AutopartesP2024.dbo.CotVtaEncabezado as cv
	UNION
	SELECT
		DISTINCT CAST(CONVERT(varchar(8), fe.Fecha, 112) AS INT),
		YEAR(fe.Fecha),
		CAST((MONTH(fe.Fecha) - 1)/6 AS INT) + 1,
		CAST((MONTH(fe.Fecha) - 1)/3 AS INT) + 1,
		MONTH(fe.Fecha),
		DAY(fe.Fecha)y,
		CASE DATEPART(WEEKDAY, fe.Fecha)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miércoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sábado'
		END AS Weekday
	FROM AutopartesP2024.dbo.FacturaEncabezado as fe;



	--Poblar FactCotizacion
	WITH CTE1 AS (
		SELECT cd.Folio, 1.0/COUNT(cd.Folio) AS Conteo
		FROM AutopartesP2024.dbo.CotVtaDetalle AS cd
		GROUP BY cd.Folio
	)

	INSERT INTO El_Ajedrecista.dbo.FactCotizacion
	SELECT 
		ce.Folio,
		cd.Articulo,
		ce.Cliente,
		ce.Vendedor,
		ce.MedioEmbarque,
		ce.CondicionPago,
		ce.Moneda,
		CAST(CONVERT(varchar(8), ce.Fecha, 112) AS INT),
		T.Conteo,
		cd.Cantidad,
		ce.pctDescuentoGlobal,
		a.Precio * cd.Cantidad
	FROM AutopartesP2024.dbo.CotVtaEncabezado as ce
	JOIN AutopartesP2024.dbo.CotVtaDetalle as cd ON ce.Folio = cd.Folio
	LEFT JOIN AutopartesP2024.dbo.Articulo as a ON a.clave = cd.Articulo
	LEFT JOIN CTE1 AS T on ce.Folio = T.Folio;
	
	


	--Poblar FactFacturacion
	WITH CTE2 AS (
		SELECT fd.Folio, 1.0/COUNT(fd.Folio) AS Conteo
		FROM AutopartesP2024.dbo.FacturaDetalle AS fd
		GROUP BY fd.Folio
	)

	INSERT INTO El_Ajedrecista.dbo.FactFacturacion
	SELECT 
		fe.Folio,
		fd.Articulo,
		fe.Cliente,
		fe.Vendedor,
		ISNULL(fe.MedioEmbarque, 'NA'),
		fe.CondicionPago,
		fe.Moneda,
		CAST(CONVERT(varchar(8), fe.Fecha, 112) AS INT),
		T.Conteo,
		fd.Cantidad,
		fd.Precio,
		fd.TotalImporte,
		fd.TotalDescuento,
		fd.TotalImpuesto,
		fd.Total
	FROM AutopartesP2024.dbo.FacturaEncabezado as fe
	JOIN AutopartesP2024.dbo.FacturaDetalle as fd ON fe.Folio = fd.Folio
	LEFT JOIN CTE2 AS T on fe.Folio = T.Folio;
END
