//Primero se borran los nodos e indexes
CALL apoc.periodic.iterate(
'MATCH (n) RETURN n',
'DETACH DELETE n',
{ batchSize:10000, parallel:false }
)

CALL apoc.schema.assert({},{},true) YIELD label, key
RETURN *

//Después se crean los nodos con sus respectivos atributos, se llenan de datos y se hacen sus respectivos indices
CALL apoc.periodic.iterate(
'LOAD csv with headers from "file:///articulo.csv" as row RETURN row', 'CREATE (n:Articulo) SET n.Folio = row.Folio, n.ArticuloID = row.ArticuloID, n.Marca = row.Marca, n.Grupo = row.Grupo, n.Tipo = row.Tipo, n.Clase = row.Clase;',
 {batchSize:10000, parallel:false }
)

CREATE index index_Articulo for (n:Articulo) on (n.ArticuloID, n.Folio);

LOAD csv with headers from "file:///condiPago.csv" as row
CREATE (n:CondicionPago)
SET
n.CondicionID = row.CondicionID,
n.Descripcion = row.Descripcion;

CREATE index index_CondicionPago for (n:CondicionPago) on (n.CondicionID);

LOAD csv with headers from "file:///cliente.csv" as row
CREATE (n:Cliente)
SET
n.ClienteID = row.ClienteID,
n.ClienteTipo = row.ClienteTipo;

CREATE index index_Cliente for (n:Cliente) on (n.ClienteID);

LOAD csv with headers from "file:///embarque.csv" as row
CREATE (n:Embarque)
SET
n.EmbarqueID = row.EmbarqueID,
n.Descripcion = row.Descripción;

CREATE index index_Embarque for (n:Embarque) on (n.EmbarqueID);

LOAD csv with headers from "file:///moneda.csv" as row
CREATE (n:Moneda)
SET
n.MonedaID = row.MonedaID,
n.Descripcion = row.Descripcion,
n.Tipo = row.Tipo;

CREATE index index_Moneda for (n:Moneda) on (n.MonedaID);

LOAD csv with headers from "file:///vendedor.csv" as row
CREATE (n:Vendedor)
SET
n.VendedorID = row.VendedorID,
n.Descripcion = row.Descripcion;

CREATE index index_Vendedor for (n:Vendedor) on (n.VendedorID);

LOAD csv with headers from "file:///subCot.csv" as row
CREATE (n:SubCotizacion)
SET
n.CotizacionID = row.CotizacionID;

CREATE index index_SubCotizacion for (n:SubCotizacion) on (n.CotizacionID);

LOAD csv with headers from "file:///subFact.csv" as row
CREATE (n:SubFacturacion)
SET
n.FacturacionID = row.FacturacionID;

CREATE index index_SubFacturacion for (n:SubFacturacion) on (n.FacturacionID);

LOAD csv with headers from "file:///cot.csv" as row
CREATE (n:Cotizacion)
SET
n.Folio = row.c_Folio,
n.Cliente = row.c_Cliente,
n.Vendedor = row.c_Vendedor,
n.Embarque = row.c_Embarque,
n.Condicion = row.c_Condicion,
n.Moneda = row.c_Moneda;

CREATE index index_Cotizacion for (n:Cotizacion) on (n.Folio, n.Cliente, n.Vendedor, n.Embarque, n.Condicion, n.Moneda);

CALL apoc.periodic.iterate(
'LOAD csv with headers from "file:///fact.csv" AS row RETURN row',
'CREATE (n:Facturacion) SET n.Folio = row.f_Folio, n.Cliente = row.f_Cliente, n.Vendedor = row.f_Vendedor, n.Embarque = row.f_Embarque, n.Condicion = row.f_Condicion, n.Moneda = row.f_Moneda',
{ batchSize:10000, parallel:false }
)

CREATE index index_Facturacion for (n:Facturacion) on (n.Folio, n.Cliente, n.Vendedor, n.Embarque, n.Condicion, n.Moneda);

//Después creamos las relaciones
CALL apoc.periodic.iterate(
 'MATCH (n:Articulo), (f:Cotizacion|Facturacion) WHERE n.Folio = f.Folio RETURN n, f',
 'MERGE (n)<-[:CONTIENE]-(f)',
 {batchSize:10000, parallel:false }
)

CALL apoc.periodic.iterate(
 'MATCH (n:CondicionPago), (f:Cotizacion|Facturacion) WHERE n.CondicionID = f.Condicion RETURN n, f',
 'MERGE (n)-[:ASOCIADA_A]->(f)',
 {batchSize:10000, parallel:false }
)

CALL apoc.periodic.iterate(
 'MATCH (n:Cliente), (f:Cotizacion|Facturacion) WHERE n.ClienteID = f.Cliente RETURN n, f',
 'MERGE (n)-[:PARTE_DE]->(f)',
 {batchSize:10000, parallel:false }
)

CALL apoc.periodic.iterate(
 'MATCH (n:Embarque), (f:Cotizacion|Facturacion) WHERE n.EmbarqueID = f.Embarque RETURN n, f',
 'MERGE (n)-[:DESTINADO_A]->(f)',
 {batchSize:10000, parallel:false }
)

CALL apoc.periodic.iterate(
 'MATCH (n:Moneda), (f:Cotizacion|Facturacion) WHERE n.MonedaID = f.Moneda RETURN n, f',
 'MERGE (n)-[:USADA_EN]->(f)',
 {batchSize:10000, parallel:false }
)

CALL apoc.periodic.iterate(
 'MATCH (n:Vendedor), (f:Cotizacion|Facturacion) WHERE n.VendedorID = f.Vendedor RETURN n, f',
 'MERGE (n)-[:SE_ENCARGA]->(f)',
 {batchSize:10000, parallel:false }
)

CALL apoc.periodic.iterate(
 'MATCH (n:SubFacturacion), (f:Facturacion) WHERE n.FacturacionID = f.Folio RETURN n, f',
 'MERGE (n)<-[:TIENE]-(f)',
 {batchSize:10000, parallel:false }
)

CALL apoc.periodic.iterate(
 'MATCH (n:SubCotizacion), (f:Cotizacion) WHERE n.CotizacionID = f.Folio RETURN n, f',
 'MERGE (n)<-[:TIENE]-(f)',
 {batchSize:10000, parallel:false }
)

//Recomendaciones
//Cotizacion
MATCH (op:Articulo)<-[:CONTIENE]-(c:Cotizacion)-[:CONTIENE]->(p:Articulo) WHERE p.ArticuloID <> op.ArticuloID 
RETURN p.ArticuloID AS ProductO, op.ArticuloID AS ProductD, c.Folio AS Folio, c.Cliente AS Cliente, c.Vendedor AS Vendedor, count(c.Folio) AS NumCot

//Facturacion Casos de Prueba
MATCH (op:Articulo)<-[:CONTIENE]-(c:Facturacion)-[:CONTIENE]->(p:Articulo)
WHERE p.ArticuloID <> op.ArticuloID AND p.ArticuloID IN ['DDDVO96             ','DDFFO00             ','SDGC93R             ','SFRA89L             ','PNT301              ','PNT187              ', 'PNT288              ']
RETURN p.ArticuloID AS ProductO, op.ArticuloID AS ProductD, c.Folio AS Folio, c.Cliente AS Cliente, c.Vendedor AS Vendedor, count(c.Folio) AS NumFact

//Facturacion Top 20
CALL {
    MATCH (n:Articulo) 
    WITH DISTINCT(n.ArticuloID) as top LIMIT 20
    RETURN top
}
MATCH (op:Articulo)<-[:CONTIENE]-(c:Facturacion)-[:CONTIENE]->(p:Articulo)
WHERE p.ArticuloID <> op.ArticuloID AND p.ArticuloID IN top
RETURN p.ArticuloID AS ProductO, op.ArticuloID AS ProductD, c.Folio AS Folio, c.Cliente AS Cliente, c.Vendedor AS Vendedor, count(c.Folio) AS NumFact