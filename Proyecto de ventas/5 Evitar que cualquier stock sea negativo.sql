--no stock negativo
create trigger trig_Nonegativos
on productos
after update 
as
begin
    if exists (select 1 from inserted where stock <0)
    begin
        raiserror ('No puede ser negativo' ,19,1);
        rollback transaction;
    end
end;