-- HASTANE YÖNETİM SİSTEMİ (Hospital Management System)

CREATE DATABASE Hastane_y_s;
GO

USE Hastane_y_s
GO

CREATE TABLE tHastalar
(
    HastalarID INT IDENTITY (1,1) not null PRIMARY KEY,
    İsim NVARCHAR (15) not null,
    Soyisim NVARCHAR (31) not null,
    HastaNumarasi CHAR (7) not null,
    TC CHAR (11) UNIQUE not null,
    Yas INT not null,
    Telefon CHAR (10) UNIQUE not null
);
GO

CREATE TABLE tDoktorlar
(
    DoktorlarID INT IDENTITY (1,1) not null PRIMARY KEY,
    İsim NVARCHAR (15) not null,
    Soyisim NVARCHAR (31) not null,
    Polikinlik NVARCHAR (63) not null
);
GO

CREATE TABLE tHemsireler
(
    HemsirelerID INT IDENTITY (1,1) not null PRIMARY KEY,
    İsim NVARCHAR (15) not null,
    Soyisim NVARCHAR (31) not null
);
GO

CREATE TABLE tTedaviSureci
(
    TedaviSureciID INT IDENTITY (1,1) not null PRIMARY KEY,
    Detay NVARCHAR (255) not null,
    HastalarID_TedaviSureciID INT, CONSTRAINT FK_HastalarID_TedaviSureciID FOREIGN KEY (HastalarID_TedaviSureciID) REFERENCES tHastalar(HastalarID),
    HemsirelerID_TedaviSureciID INT, CONSTRAINT FK_HemsirelerID_TedaviSureciID FOREIGN KEY (HemsirelerID_TedaviSureciID) REFERENCES tHemsireler(HemsirelerID),
    DoktorlarID_TedaviSureciID INT, CONSTRAINT FK_DoktorlarID_TedaviSureciID FOREIGN KEY (DoktorlarID_TedaviSureciID) REFERENCES tDoktorlar(DoktorlarID)
);
GO

CREATE TABLE tIlaclar
(
    IlaclarID INT IDENTITY (1,1) not null PRIMARY KEY,
    İsim NVARCHAR (63) not null,
    SonKullanimTarihi DATE not null,
    Miktar INT not null,
    Tutar INT not null
);
GO

CREATE TABLE tRecete
(
    ReceteID INT IDENTITY (1,1) not null PRIMARY KEY,
    DoktorID_ReceteID INT, CONSTRAINT FK_DoktorID_ReceteID FOREIGN KEY (DoktorID_ReceteID) REFERENCES tDoktorlar(DoktorlarID),
    HastalarID_ReceteID INT, CONSTRAINT FK_HastalarID_ReceteID FOREIGN KEY (HastalarID_ReceteID) REFERENCES tHastalar(HastalarID),
    IlaclarID_ReceteID INT, CONSTRAINT FK_IlaclarID_ReceteID FOREIGN KEY (IlaclarID_ReceteID) REFERENCES tIlaclar(IlaclarID)
);
GO

--  VERİ GİRİŞİ (INSERT) İŞLEMLERİ
USE Hastane_y_s
GO

INSERT INTO tHastalar(İsim, Soyisim, HastaNumarasi, TC, Yas, Telefon)
VALUES ( 'Osman', 'Demir', '1234567', '11111111111', '45', '5555555555')
GO

INSERT INTO tDoktorlar(İsim, Soyisim, Polikinlik)
VALUES ( 'Osman', 'Demir', 'Ortopedi')
GO

INSERT INTO tHemsireler(İsim, Soyisim)
VALUES ( 'Omer', 'Demir')
GO

INSERT INTO tTedaviSureci(Detay, HastalarID_TedaviSureciID, HemsirelerID_TedaviSureciID, DoktorlarID_TedaviSureciID)
VALUES ( 'Kemik Kırıkları', 1, 1, 1)
GO

INSERT INTO tIlaclar(İsim, SonKullanimTarihi, Miktar, Tutar)
VALUES ( 'Parol', '2027-01-01', '2', '300')
GO

INSERT INTO tRecete(DoktorID_ReceteID, HastalarID_ReceteID, IlaclarID_ReceteID)
VALUES (1, 1, 1)
GO

/*
-- VERİ TABANI SIFIRLAMA / TEMİZLEME (OPTIONAL RESET)
-- Not: Aşağıdaki kodlar, veritabanını tamamen silmek ve
-- sistemi sıfırlamak istendiğinde kullanılmak üzere hazırlanmıştır.
-- Güvenlik amacıyla yorum satırı haline getirilmiştir.
-- Çalıştırmak için yorum işaretlerini (/* ... */) kaldırınız.

USE Hastane_y_s
GO

ALTER TABLE tTedaviSureci
DROP CONSTRAINT FK_HastalarID_TedaviSureciID, FK_HemsirelerID_TedaviSureciID, FK_DoktorlarID_TedaviSureciID
GO

ALTER TABLE tRecete
DROP CONSTRAINT FK_DoktorID_ReceteID, FK_HastalarID_ReceteID, FK_IlaclarID_ReceteID
GO

DROP TABLE tTedaviSureci, tRecete, tIlaclar, tHemsireler, tDoktorlar, tHastalar
GO
*/
