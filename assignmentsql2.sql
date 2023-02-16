-- Postavljanje indexa na tabeli korisnik
ALTER TABLE korisnik ADD INDEX idx_korisnik_prezime (prezime);
ALTER TABLE korisnik ADD INDEX idx_korisnik_korisnicko_ime (korisničko_ime);
ALTER TABLE korisnik ADD FULLTEXT INDEX idx_korisnik_biografija (biografija);

-- Postavljanje indexa na tabeli plata
ALTER TABLE plata ADD INDEX idx_plata_korsinik_id (korisnik_id);
ALTER TABLE plata ADD INDEX idx_plata_datum_plate (datum_plate);

-- Postavljanje indexa na tabeli poruka
ALTER TABLE poruka ADD INDEX idx_poruka_posiljalac_id (pošiljalac_id);
ALTER TABLE poruka ADD INDEX idx_poruka_primalac_id (primalac_id);
ALTER TABLE poruka ADD INDEX idx_poruka_status (status);
ALTER TABLE poruka ADD FULLTEXT INDEX idx_poruka_sadrzaj (sadržaj);

-- Kreiranje pogleda koji pokazuje osnovne informacije
CREATE VIEW korisnik_osnovne_informacije AS
SELECT ime, prezime, datum_rođenja
FROM korisnik;

-- Kreiranje uskladistene procedure za unos korisnika
DELIMITER //
CREATE PROCEDURE unoskorisnika(
  IN p_ime VARCHAR(50),
  IN p_prezime VARCHAR(50),
  IN p_datum_rođenja DATE,
  IN p_email VARCHAR(50),
  IN p_korisničko_ime VARCHAR(50),
  IN p_biografija TEXT,
  IN p_fotografija BLOB
)

BEGIN
    INSERT INTO korisnik (ime, prezime, datum_rođenja, email, korisničko_ime, biografija, fotografija)
    VALUES (p_ime, p_prezime, p_datum_rođenja, p_email, p_korisničko_ime, p_biografija, p_fotografija);
END;


-- Kreiranje uskladistene procedure za izmjenu korisnika
DELIMITER //
CREATE PROCEDURE izmjena_korisnika(
  IN p_id INT,
  IN p_ime VARCHAR(50),
  IN p_prezime VARCHAR(50),
  IN p_datum_rođenja DATE,
  IN p_email VARCHAR(50),
  IN p_korisničko_ime VARCHAR(50),
  IN p_biografija TEXT,
  IN p_fotografija BLOB
)
BEGIN
UPDATE korisnik
SET 
ime = p_ime,
prezime = p_prezime,
datum_rođenja = p_datum_rođenja,
email = p_email,
korisničko_ime = p_korisničko_ime,
biografija = p_biografija,
fotografija = p_fotografija
WHERE id = p_id;
END;


-- Kreiranje uskladistene procedure za brisanje korisnika
DELIMITER //
CREATE PROCEDURE BrisanjeKorisnika(IN p_id INT)
BEGIN 
DELETE FROM korisnik WHERE id = p_id;
END;

-- Kreiranje uskladistene procedure za unos podataka o platma
DELIMITER //
CREATE PROCEDURE dodaj_platu (
IN p_datum_plate DATE,
IN p_iznos DECIMAL(10, 2),
IN p_status ENUM('isplaćena', 'neisplaćena'),
IN p_tip_zaposlenja ENUM ('ugovor na određeno', 'ugovor na neodređeno'),
IN p_korisnik_id INT
)
BEGIN
INSERT INTO plata (datum_palte, iznos, status, tip_zaposlenja, korisnik_id)
VALUES (p_datum_plate, p_iznos, p_status, p_tip_zaposlenja, p_korsinik_id);
END;

-- Kreiranje uskladistene procedure za brisanje podataka o plati
DELIMITER //
CREATE PROCEDURE obrisi_platu(
IN plata_id INT
)
BEGIN
DELETE FROM plata WHERE id = palta_id;
END;

-- Kreiranje uskladistene procedure za izmejnu podataka o platama 
DELIMITER //
CREATE PROCEDURE izmeni_platu (
IN p_plata_id INT,
IN p_datum_plate DATE,
IN p_iznos DECIMAL(10, 2),
IN p_status ENUM('isplaćena', 'neisplaćena'),
IN p_tip_zaposlenja ENUM ('ugovor na određeno', 'ugovor na neodređeno'),
IN p_korisnik_id INT
)
BEGIN
UPDATE plata
SET 
datum_plate = p_datum_plate,
iznos = p_iznos,
status = p_status,
tip_zaposlenja = p_tip_zaposlenja,
korisnik_id = p_korsinik_id
WHERE id = plata_id;
END;

-- Kreiranje uskladistene procedure za unos poruke
DELIMITER //
CREATE PROCEDURE unesi_poruku (
IN p_sadržaj TEXT,
IN p_datum DATE,
IN p_status ENUM('pročitana', 'neporčitana'),
IN p_pošiljalac_id INT,
IN p_primalac_id INT
) 
BEGIN
INSERT INTO poruka (sadržaj, datum, status, pošiljalac_id, primalac_id)
VALUES (p_sadržaj, p_datum, p_status, pošiljalac_id, primalac_id);
END;

-- Kreiranje uskladistene procedure za brisanje poruke
DELIMITER //
CREATE PROCEDURE obrisi_poruku(
IN poruka_id INT
)
BEGIN
DELETE FROM poruka WHERE id = poruka_id;
END;

-- Kreiranje uskladistene procedure za izmjenu prouke
DELIMITER //
CREATE PROCEDURE izmjeni_poruku(
IN p_poruka_id INT,
IN p_sadržaj TEXT,
IN p_datum DATE,
IN p_status ENUM('pročitana', 'neporčitana'),
IN p_pošiljalac_id INT,
IN p_primalac_id INT
)
BEGIN
UPDATE poruka
SET sadržaj = p_sadržaj,
datum = p_datum,
status = p_status,
pošiljalac_id = p_pošiljalac_id,
primalac_id = p_primalac_id
WHERE id = poruka_id;
END;

-- Kreiranje funkcije koja će za prosleđeni parametar identifikacionog broja korisnika da prebroji i vrati ukupan broj njegovih poslatih poruka.
CREATE FUNCTION broj_poslatih_poruka(
korisnik_id INT
) RETURNS INT
BEGIN
DECLARE broj_poruka INT;
SELECT COUNT(*) INTO broj_popruka FROM poruka WHERE pošiljalac_id = korisnik_id;
RETURN broj_poruka;
END; 


  
  
