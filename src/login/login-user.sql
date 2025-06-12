--Usamos la master para poder crear un login
USE master
GO

--Creamos los login deseados con respectivas con sus contraseñas
CREATE LOGIN martillo WITH PASSWORD = '123456';
CREATE LOGIN francisco_coulon WITH PASSWORD = 'coulon123';
CREATE LOGIN usuario_normal WITH PASSWORD = 'usuario123';
GO

--Luego elegimos la local para poder asignar los permisos de cada uno
USE mi_cine_es_tu_cine
GO

--Creamos el usuario con su respectivo login y sus permisos
CREATE USER martillo FOR LOGIN martillo;
ALTER ROLE db_datareader ADD MEMBER martillo;
ALTER ROLE db_datawriter ADD MEMBER martillo;
ALTER ROLE db_owner ADD MEMBER martillo;



CREATE USER francisco_coulon FOR LOGIN francisco_coulon;
ALTER ROLE db_datareader ADD MEMBER francisco_coulon;
ALTER ROLE db_datawriter ADD MEMBER francisco_coulon;
ALTER ROLE db_owner ADD MEMBER francisco_coulon;

--Se le aigna manual a que puede ver
GRANT SELECT ON dbo.vw_asiento_disponibles TO usuario_normal;
GRANT SELECT ON dbo.vw_pelicula_actor TO usuario_normal;
GRANT SELECT ON dbo.vw_peliculas_mas_vendidas TO usuario_normal;
GRANT SELECT ON dbo.vw_pelicula_sub_idioma TO usuario_normal;
GRANT SELECT ON dbo.vw_sala_asientos TO usuario_normal;
GRANT SELECT ON dbo.vw_pelicula_cartelera_isa TO usuario_normal;
GRANT SELECT ON dbo.vw_pelicula_sala_asiento_funcion TO usuario_normal;

GO


SELECT dp.name AS Usuario,
       o.name AS Objeto,
       p.permission_name AS Permiso,
       p.state_desc AS Estado
FROM sys.database_permissions p
JOIN sys.database_principals dp ON p.grantee_principal_id = dp.principal_id
LEFT JOIN sys.objects o ON p.major_id = o.object_id
WHERE dp.name = 'usuario_normal';
GO