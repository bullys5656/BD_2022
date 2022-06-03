use negocio;
call SP_procedures;
call SP_vistas;

drop procedure if exists SP_articulos_insert;

delimiter //
create procedure SP_articulos_insert(in Pdescripcion varchar(50),Prubro varchar(20)
,Pcosto double,Pprecio double,Pstock int,Pstock_minimo int,Pstock_maximo int)
begin 
	insert into articulos (descripcion,rubro,costo,precio,stock,stock_minimo,stock_maximo)
		values
	(Pdescripcion,Prubro,Pcosto,Pprecio,Pstock,Pstock_minimo,Pstock_maximo);
end;
// delimiter ;
call SP_articulos_insert('Jabon liquido','LIMPIEZA',500,800,50,15,500);

select * from articulos;

drop procedure if exists SP_Articulos_remove;

delimiter //
create procedure SP_Articulos_remove(in Pid int)
begin
	delete from articulos where id=Pid;
    end;
// delimiter ;

call SP_Articulos_remove(3);

select * from articulos;

drop procedure if exists  SP_Articulos_update;

delimiter //
create procedure SP_Articulos_update(in Pid int, Pdescripcion varchar(50),Prubro varchar(20)
,Pcosto double,Pprecio double,Pstock int,Pstock_minimo int,Pstock_maximo int)
begin
	update articulos set descripcion=Pdescripcion, rubro=Prubro, costo=Pcosto, precio=Pprecio,
     stock=Pstock, stock_minimo=Pstock_minimo,stock_maximo=Pstock_maximo where id=Pid;
     end;
     // delimiter ;
	select * from articulos;
    call SP_Articulos_update(4,'Queso','FIAMBRES',200,400,50,15,500);
	
