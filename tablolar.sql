

CREATE TABLE Musteriler (
    MusteriID SERIAL PRIMARY KEY,
    ad VARCHAR ,
    soyad VARCHAR(50),
    telefon CHAR(11),
    eposta VARCHAR(100),
    adres VARCHAR(255)
);

CREATE TABLE MusteriSegmentleri (
    SegmentID SERIAL PRIMARY KEY,
    SegmentAd VARCHAR(50)
    
);

CREATE TABLE Urunler (
    UrunID SERIAL PRIMARY KEY,
    UrunAdi VARCHAR(50),
    UrunFiyati NUMERIC(10,2),
    UrunAciklamasi VARCHAR(255),
	stokdurumu VARCHAR,
    kategori VARCHAR(50),
    stok_miktari INTEGER
);

CREATE TABLE Satislar (
    SatisID SERIAL PRIMARY KEY,
    MusteriID INTEGER REFERENCES Musteriler(MusteriID),
    SatisTarihi DATE
);

CREATE TABLE SatisDetaylari (
    SatisDetayID SERIAL PRIMARY KEY,
    SatisID INTEGER REFERENCES Satislar(SatisID),
    UrunID INTEGER REFERENCES Urunler(UrunID),
    Miktar INTEGER,
    ToplamTutar NUMERIC(10,2)
);

CREATE TABLE Notlar (
    NotID SERIAL PRIMARY KEY,
    MusteriID INTEGER REFERENCES Musteriler(MusteriID),
    NotTarihi DATE,
    NotIcerigi TEXT
);

CREATE TABLE MusteriTercihleri (
    TercihID SERIAL PRIMARY KEY,
    MusteriID INTEGER REFERENCES Musteriler(MusteriID),
    TercihTipi VARCHAR(100),
    TercihDetayi TEXT
);

CREATE TABLE Kampanyalar (
    KampanyaID SERIAL PRIMARY KEY,
    SegmentID INTEGER REFERENCES MusteriSegmentleri(SegmentID),
    KampanyaAdi VARCHAR(100),
    BaslangicTarihi DATE,
    BitisTarihi DATE
);

CREATE TABLE KampanyaEtkilesimleri (
    KampanyaEtkilesimID SERIAL PRIMARY KEY,
    KampanyaID INTEGER REFERENCES Kampanyalar(KampanyaID),
    MusteriID INTEGER REFERENCES Musteriler(MusteriID),
    EtkilesimTarihi DATE,
    EtkilesimTuru VARCHAR(100),
    EtkilesimSonucu VARCHAR(100)
);

CREATE TABLE Etkinlikler (
    EtkinlikID SERIAL PRIMARY KEY,
    EtkinlikBasligi VARCHAR(255),
    EtkinlikTarihi DATE,
    EtkinlikYeri VARCHAR(255)
);

CREATE TABLE EtkinlikMusteri (
    EtkinlikMusteriID SERIAL PRIMARY KEY,
    EtkinlikID INTEGER REFERENCES Etkinlikler(EtkinlikID),
    MusteriID INTEGER REFERENCES Musteriler(MusteriID)
);

CREATE TABLE DestekTalepleri (
    TalepID SERIAL PRIMARY KEY,
    MusteriID INTEGER REFERENCES Musteriler(MusteriID),
    TalepTarihi DATE,
    Durum VARCHAR(25),
    Aciklama TEXT
);

CREATE TABLE Etkilesimler (
    Etkilesimid SERIAL PRIMARY KEY,
    MusteriID INTEGER REFERENCES Musteriler(MusteriID),
    etkilesimTarihi DATE,
    etkilesimTuru VARCHAR(255),
    etkilesimnotlari TEXT
);

