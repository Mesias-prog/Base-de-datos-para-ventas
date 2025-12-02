use SistemasVentas;
go
create procedure insertarventa
    @Ventaid varchar(10),
    @Clienteid int,
    @Detalles Detalleventastype readonly
as
begin
    begin transaction;
    begin try
        --venta
        insert into  Ventas (Ventaid, Clienteid)
        values (@Ventaid, @Clienteid);
        --precios
        insert into detalleventas (Ventaid, Productoid, Cantidad, Preciounitario)
        select 
            @Ventaid,
            d.Productoid,
            d.Cantidad,
            p.Preciounitario
        from @Detalles d inner join productos p on d.Productoid = p.Productoid;
        --stock
        update p
        set p.stock = p.stock - d.Cantidad
        from Productos p inner join @Detalles d ON p.Productoid = d.Productoid;
        --se calcular el total
        declare @total decimal(10,2);
        select @total = SUM(Subtotal) from detalleventas where Ventaid = @Ventaid;
        update ventas
        set total = @total
        where Ventaid = @Ventaid;
        commit transaction;
    end try
    begin catch
        rollback transaction ;
        throw;
        end catch
end;
go
