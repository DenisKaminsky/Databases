CREATE DATABASE DenisKaminskyDatabase;

USE DenisKaminskyDatabase;
GO

CREATE SCHEMA sales;
GO

CREATE SCHEMA persons;
GO

CREATE TABLE sales.Orders (OrderNum INT NULL);
GO

BACKUP DATABASE DenisKaminskyDatabase TO "backup";
GO

USE master;
GO

DROP DATABASE DenisKaminskyDatabase;	
GO

RESTORE DATABASE DenisKaminskyDatabase FROM "backup";
GO

