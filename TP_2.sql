use negocio;
drop table if exists control_db;
create table control_db(
	id int auto_increment primary key,
    fecha date,
    hora time,
    usuario varchar(30),
    tabla varchar(30) not null,
    accion enum('INSERT','DELETE','UPDATE'),
    idRegistro int
);

drop trigger if exists TR_articulos_insert;
delimiter //
create trigger TR_articulos_insert 
	after insert on articulos
    for each row
    begin
		insert into control_db (fecha,hora,usuario,tabla,accion,idRegistro) 
        values (curdate(),curtime(),'Alejandro','Articulos','INSERT',new.id);
    end;
// delimiter ;
Insert into articulos(descripcion,rubro,costo,precio,stock,stock_minimo,stock_maximo)values
("Leche",'LACTEOS',90.00,190.00,100,50,500),
("Queso",'LACTEOS',300.00,900.00,200,50,1000);

select * from articulos;
select * from control_db;

CREATE TABLE articulos_borrados LIKE articulos;
show tables;
describe articulos_borrados;

drop trigger if exists TR_articulos_delete;

delimiter //
create trigger TR_articulos_delete
	after delete on articulos
    for each row
    begin
		insert into articulos_borrados (id,descripcion,rubro,costo,precio,stock,stock_minimo,stock_maximo)
        values (old.id,old.descripcion,old.rubro,old.costo,old.precio,old.stock,old.stock_minimo,old.stock_maximo);
		insert into control_db (fecha,hora,usuario,tabla,accion,idRegistro) 
        values (curdate(),curtime(),'Alejandro','Articulos','DELETE',old.id);
    end;
// delimiter ;

select * from articulos;
delete from articulos where id=6;
select * from control_db;
select * from articulos_borrados;


insert into articulos select * from articulos_borrados where id=3;
delete from articulos_borrados where id=6;

drop table if exists articulos_actualizados;
create table articulos_actualizados  like articulos;

drop trigger if exists TR_articulos_update;
delimiter //
create trigger TR_articulos_update 
	after update on articulos
    for each row
    begin
		insert into articulos_actualizados 
			(id,descripcion,rubro,costo,precio,stock,stock_minimo,stock_maximo)
        values 
			(old.id,old.descripcion,old.rubro,old.costo,old.precio,old.stock,old.stock_minimo,old.stock_maximo);
		insert into control_db (fecha,hora,usuario,tabla,accion,idRegistro) 
        values (curdate(),curtime(),'Alejandro','Articulos','UPDATE',new.id);
    end;
// delimiter ;

update articulos set descripcion='crema' where id=5;
select * from articulos;
select * from control_DB;
select * from articulos_actualizados;