create view viw_Productosajostock as
select Productoid, NombreProducto, stock
from productos
where stock<10;
create view viw_Resumenventa as
select 
    v.Ventaid,
    c.NombreCliente,
    v.FechaVenta,
    v.total
from ventas v inner join Clientes c on v.Clienteid=c.Clienteid;

