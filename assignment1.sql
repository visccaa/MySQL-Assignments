-- KREIRANJE TABELE KORISNIK
CREATE TABLE Korisnik (
  id INT PRIMARY KEY AUTO_INCREMENT,
  ime VARCHAR(50),
  prezime VARCHAR(50),
  datum_rođenja DATE,
  email VARCHAR(50),
  korisničko_ime VARCHAR(50),
  biografija TEXT,
  fotografija BLOB
);

-- KREIRANJE TABELE PLATA
CREATE TABLE Plata (
  id INT PRIMARY KEY AUTO_INCREMENT,
  datum_plate DATE,
  iznos DECIMAL(10, 2),
  status ENUM('isplaćena', 'neisplaćena'),
  tip_zaposlenja ENUM('ugovor na određeno', 'ugovor na neodređeno'),
  korisnik_id INT,
  FOREIGN KEY (korisnik_id) REFERENCES Korisnik(id)
);

-- KREIRANJE TABELE PORUKA
CREATE TABLE Poruka (
  id INT PRIMARY KEY AUTO_INCREMENT,
  sadržaj TEXT,
  datum DATE,
  status ENUM('pročitana', 'nepročitana'),
  pošiljalac_id INT,
  primalac_id INT,
  FOREIGN KEY (pošiljalac_id) REFERENCES Korisnik(id),
  FOREIGN KEY (primalac_id) REFERENCES Korisnik(id)
);




