-- Tworzenie bazy danych
CREATE DATABASE uczniowie;

-- Wybieranie bazy danych
USE uczniowie;

-- Usuwanie bazy danych
DROP DATABASE uczniowie;

-- Tworzenie tabeli z kluczem podstawowym
CREATE TABLE tabela_uczniowie (
      id_ucznia int NOT NULL AUTO_INCREMENT,
      imie varchar(20),
      nazwisko varchar(20),
      plec char(1),
      adres_zamieszkania varchar(20),
      email varchar(30),
      data_urodzenia date,
      PRIMARY KEY (id_ucznia)
);

-- Tworzenie tabeli poprzez kopiowanie kolumn z innej tabeli
CREATE TABLE tabela_szkoła AS
SELECT imie, nazwisko
FROM tabela_uczniowie;

-- Usuwanie CAŁEJ tabeli
DROP TABLE tabela_uczniowie;

-- Czyszczenie ZAWARTOŚCI tabeli ale pozostawienie jej STRUKTURY
TRUNCATE TABLE tabela_uczniowie;

-- Wybieranie wszystkich kolumn z tabeli
SELECT * FROM tabela_uczniowie;

-- Wybieranie wybranych kolumn z tabeli
SELECT imie, nazwisko
FROM tabela_uczniowie;

-- Wybieranie unikalnych wpisów z kolumny(każdy wpis może wystąpić tylko raz)
SELECT DISTINCT nazwisko
FROM tabela_uczniowie;

-- Liczba wszystkich wpisów w kolumnie
SELECT COUNT(DISTINCT nazwisko)
FROM tabela_uczniowie;

-- Wybieranie wpisów z kolumny o wartości 'Koszyk'
SELECT * FROM tabela_uczniowie
WHERE nazwisko = 'Koszyk';

-- Wybieranie wpisów z kolumny różnych od wartości 'Koszyk'
SELECT * FROM tabela_uczniowie
WHERE nazwisko <> 'Koszyk';

-- Operatory w klauzuli WHERE
OPERATOR                OPIS
   =                  'równe'
   >                  'większe niż'
   <                  'mniejsze niż'
   >=                 'większe lub równe'
   <=                 'mniejsze lub równe'
<> albo !=            'różne od'
 BETWEEN              'w przedziale "od" "do"'
LIKE (%, _, [], ^, -) 'szukanie wartości o podanym wzorze'
  (ad%     - np. adam, ad
   k_t     - np. kot
   k[oi]t  - np. kot, kit, ale nie kat
   k[^oi]t - np. kat, ale nie kot, kit
   h[a-b]k - hak, hbk
  )
   IN ()    'wybieranie wartości podanych w                  nawiasie'
   
-- Wybieranie wpisów spełniających wszystkie podane warunki (AND)
SELECT * FROM tabela_uczniowie
WHERE imie='Paweł' AND nazwisko='Koszyk';

-- Wybieranie wpisów spełaniających przynajmniej jeden warunek (OR)
SELECT * FROM tabela_uczniowie
WHERE imie='Krzysztof' OR nazwisko='Grygiel';

-- Wybieranie wszystkich wpisów oprócz tego podanego w warunku (NOT)
SELECT * FROM tabela_uczniowie
WHERE NOT nazwisko='Koszyk';

-- Połączenia AND, OR, NOT 
SELECT * FROM tabela_uczniowie
WHERE email LIKE '%w%' AND (adres_zamieszkania='Stary Sącz' OR adres_zamieszkania='Paszyn');

-- Sortowanie rekordów rosnąco wg wybranej kolumny
SELECT * FROM Customers
ORDER BY Country;

-- Sortowanie malejąco wg wybranej kolumny
SELECT * FROM tabela_uczniowie
ORDER BY nazwisko DESC;

-- Sortowanie jednej kolumny rosnąco a drugiej malejąco 
SELECT * FROM tabela_uczniowie
ORDER BY nazwisko ASC, data_urodzenia DESC;

-- Dodawanie nowego rekordu
INSERT INTO tabela_uczniowie(id_ucznia, imie, nazwisko, plec, adres_zamieszkania, email, data_urodzenia)
VALUES ('', 'Kamil', 'Krawczyk', 'M', 'Korzenna', 'kamil.krawczyk@gmail.com', '2003-06-09' );

-- Wybieranie kolumn imie i nazwisko gdzie imie (nie) ma wartość NULL (pole jest puste)
SELECT imie, nazwisko
FROM tabela_uczniowie
WHERE imie IS (NOT) NULL;

-- Modyfikowanie istnuiejących rekordów w tabeli
UPDATE tabela_uczniowie
SET  nazwisko = 'Brattig', adres_zamieszkania = 'Grybów', email='kamil.brattig@gmail.com'
WHERE id_ucznia = 6;

-- Usuwanie istniejącego rekordu w tabeli
DELETE FROM tabela_uczniowie 
WHERE nazwisko = 'Krawczyk';

-- Usuwanie zawartości tabeli z zachowaniem jej struktury
DELETE FROM tabela_uczniowie;

-- Liczba rekordów wyświetlanych na jednej stronie 
SELECT * FROM tabela_uczniowie
LIMIT 3;

-- Wybieranie trzech pierwszych rekordów o wartości 'Paweł'
SELECT * FROM tabela_uczniowie
WHERE imie = 'Paweł'
LIMIT 3;

-- Funkcja zwracająca najmniejszą wartość wybranej kolumny
SELECT MIN(cena) AS NajmniejszaCena
FROM produkty;

-- Funkcja zwracająca największą wartość wybranej kolumny
SELECT MAX(cena) AS NajwiększaCena
FROM produkty;

-- Funkcja zwracająca liczbę wierszy które pasują do podanych kryteriów
SELECT COUNT(id_produktu)
FROM produkty;

-- Funkcja zwracająca średnią wartość kolumny numerycznej
SELECT AVG(cena)
FROM produkty;

-- Funkcja zwracająca sumę wartości kolumny numerycznej
SELECT SUM(cena)
FROM produkty;

-- Wybranie produktów od 'karta graficzna' do 'SSD' uporządkoanych rosnąco
SELECT * FROM produkty
WHERE nazwa_produktu BETWEEN 'karta graficzna' AND 'SSD'
ORDER BY nazwa_produktu;

-- Tworzenie pseudonimów dla kolumn na czas zapytania
SELECT id_ucznia AS ID, adres_zamieszkania AS adres
FROM tabela_uczniowie;

-- Zadania gr.A
1. CREATE TABLE klienci(
      id int AUTO_INCREMENT,
      imie text,
      nazwisko text,
      id_... int,
      PRIMARY KEY (id),
      FOREIGN KEY (id_...) REFERENCES nazwaTabeli(id_...)
);

2. INSERT INTO bank (...)
  VALUES ('...');

3. UPDATE wpływy SET wpływy='1300'
WHERE id = 3;

4. TRUNCATE TABLE bank;

5. SELECT Klienci.Imie, Klienci.Nazwisko, Bank.wydatki
FROM Klienci
INNER JOIN Bank ON Klienci.id = Bank.id;

-- Zadania gr.B
1. CREATE TABLE bank(
      id int AUTO_INCREMENT,
      wydatki int,
      PRIMARY KEY (id)
);

2. UPDATE klienci SET nazwisko = '...'
WHERE id = 3;

3. DROP TABLE klienci;

4. DROP TABLE bank;

5.CREATE VIEW [1995] AS 
SELECT imie FROM klienci 
WHERE id = 2;

6. SELECT imie FROM klienci
WHERE data_urodzenia LIKE '1996%';

-- Wybieranie imie, nazwisko z tabeli_uczniowie oraz klasa z tabeli tabela_szkoła
SELECT tabela_uczniowie.imie, tabela_uczniowie.nazwisko, tabela_szkoła.klasa
FROM tabela_uczniowie
INNER JOIN tabela_szkoła ON tabela_uczniowie.id_ucznia = tabela_szkoła.id_ucznia;

-- Wybieranie imie z tabela_uczniowie, klasa z tabela_szkoła i nazwa_produktu z produkty
SELECT tabela_uczniowie.imie, tabela_szkoła.klasa, produkty.nazwa_produktu
FROM ((tabela_uczniowie
INNER JOIN tabela_szkoła ON tabela_uczniowie.id_ucznia = tabela_szkoła.id_ucznia)
INNER JOIN produkty ON produkty.id_ucznia = tabela_uczniowie.id_ucznia);

-- Wybranie wszystkich wybranych rekordów z tabela_uczniowie i dopasowanych rekordów z produkty
SELECT tabela_uczniowie.imie, produkty.nazwa_produktu
FROM tabela_uczniowie
LEFT JOIN produkty ON tabela_uczniowie.id_ucznia = produkty.id_ucznia;

-- Wybranie wszystkich wybranych rekordów z produkty i dopasowanych rekordów z tabela_uczniowie
SELECT produkty.nazwa_produktu, tabela_uczniowie.imie, tabela_uczniowie.nazwisko
FROM produkty
RIGHT JOIN tabela_uczniowie ON produkty.id_ucznia = tabela_uczniowie.id_ucznia;

-- Połączenie tabeli z samą sobą
SELECT A.imie AS ImieUczen, B.nazwisko AS NazwiskoUczen, A.adres_zamieszkania
FROM tabela_uczniowie A, tabela_uczniowie B 
WHERE A.id_ucznia = B.id_ucznia AND A.adres_zamieszkania = B.adres_zamieszkania;

-- Wybranie kolumny imie z dwóch tabel (bez duplikatów)
SELECT imie FROM tabela_uczniowie
UNION
SELECT imie FROM klienci
ORDER BY imie;

-- Wybranie kolumny imie z dwóch tabel (duplikaty)
SELECT imie FROM tabela_uczniowie
UNION ALL
SELECT imie FROM klienci
ORDER BY imie;

-- Liczenie, ile osób ma dane imię
SELECT COUNT(id_ucznia), imie
FROM tabela_uczniowie
GROUP BY imie;

-- Liczenie, ile klientów kupiło dany produkt
SELECT produkty.nazwa_produktu, COUNT(tabela_uczniowie.imie) AS LiczbaKlienci FROM produkty
INNER JOIN tabela_uczniowie ON tabela_uczniowie.id_ucznia = produkty.id_produktu
GROUP BY nazwa_produktu;

-- Odpowiednik WHERE dla SELECT (z funkcjami agregującymi) 
Liczenie ile jest imion o id_ucznia większym od 1
SELECT COUNT(id_ucznia), imie
FROM tabela_uczniowie
GROUP BY imie
HAVING COUNT(id_ucznia) > 1;

-- Liczenie ile jest imion o id_ucznia większym od 1 (malejąco)
SELECT COUNT(id_ucznia), imie
FROM tabela_uczniowie
GROUP BY imie
HAVING COUNT(id_ucznia) > 1
ORDER BY COUNT(id_ucznia) DESC;

-- Wybieranie wartości z kolumny imie z tabela_uczniowie, dla których id_szkoła jest większe od 8
SELECT imie
FROM tabela_uczniowie
WHERE EXISTS (SELECT imie FROM tabela_szkoła WHERE tabela_uczniowie.id_ucznia = tabela_szkoła.id_ucznia AND id_szkoła > 8);

-- Wybieranie nazw produktu, których id jest różne od 300
SELECT nazwa_produktu
FROM produkty
WHERE id_produktu <> ALL (SELECT id_produktu FROM produkty WHERE cena = 300);

-- Kopiowanie  całej zawartości tabela_uczniowie do tabeli klasa_1p
SELECT * INTO klasa_1p
FROM tabela_uczniowie;

-- Kopiowanie  kolumn imie i nazwisko z tabela_uczniowie do tabeli klasa_1p
SELECT imie, nazwisko INTO klasa_1p
FROM tabela_uczniowie;

-- Kopiowanie z kolumny imie rekordów o wartości 'Paweł' z tabela_uczniowie do tabeli klasa_1p
SELECT * INTO klasa_1p
FROM tabela_uczniowie
WHERE imie = 'Paweł';

-- Wstawianie rekordów z jednej tabeli do drugiej
INSERT INTO klienci (imie, nazwisko)
SELECT imie, nazwisko  FROM tabela_uczniowie;

-- Sprawdzanie warunków (jeżeli są spełnione, to zwraca odpowiednie wartości, w przeciwnym wypadku przechodzi do ELSE. Jeśli tam nie ma spełnionych warunków to baza danych zwraca wartość NULL)
SELECT imie, nazwisko, data_urodzenia,
CASE
   WHEN data_urodzenia LIKE '1995%' THEN "Urodzeni przed 1996 rokiem"
   WHEN data_urodzenia LIKE '1996%' THEN "Urodzeni W 1996 roku"
   ELSE "Urodzeni po 1996 roku"
END AS PodziałDataUrodzenia
FROM klienci;

-- Wybieranie imie (jeśli plec ma pole NULL to zostaną zwrócone 0) i nazwisko z tabela_uczniowie 
SELECT nazwisko, imie * (COALESCE(plec, 1))
FROM tabela_uczniowie;

-- Zmiana struktury tabeli
1.Dodanie kolumny
ALTER TABLE tabela_uczniowie
ADD (COLUMN) zainteresowania varchar(50);

2.Usunięcie kolumny
ALTER TABLE tabela_uczniowie
DROP (COLUMN) zainteresowania varchar(50);

3.Modyfikacja kolumny 
ALTER TABLE tabela_uczniowie
ALTER COLUMN (MODIFY) zainteresowania varchar(50);

-- Ograniczenia (CONSTRAINT)
NOT NULL - kolumna nie może zawierać wartości NULL
UNIQUE - wartości w kolumnie nie mogą się powtarzać
PRIMARY KEY - uniklane wartości kolumny (NOT NULL + UNIQUE)
FOREIGN KEY - relacja jeden do wielu, jednoznacznie identyfikuje rekord w innej tabeli
CHECK - wszystkie wartości w kolumnie spełniają specyficzny warunek
DEFAULT - domyślna wartość kolumny
INDEX - szybsze pobieranie danych z tabeli

-- NOT NULL 
CREATE TABLE tabela_uczniowie (
      id_ucznia int NOT NULL,
      ...
);
ALTER TABLE tabela_uczniowie
MODIFY wiek int NOT NULL;

-- UNIQUE
a) CREATE TABLE tabela_uczniowie (
      id_ucznia int UNIQUE,
      ...
);
b) ALTER TABLE tabela_uczniowie
ADD UNIQUE (id_ucznia);

-- Nazwa UNIQUE
a) CREATE TABLE tabela_uczniowie (
      id_ucznia int NOT NULL,
      imie varchar(20),
      nazwisko varchar(20),
      CONSTRAINT UC_ucznia UNIQUE (id_ucznia)
);
b) ALTER TABLE tabela_uczniowie
ADD CONSTRAINT UC_ucznia UNIQUE (id_ucznia);

-- Usuwanie UNIQUE
ALTER TABLE tabela_uczniowie
DROP CONSTRAINT (UNIQUE) UC_ucznia;

-- PRIMARY KEY (klucz podstawowy)
a) CREATE TABLE tabela_uczniowie (
      id_ucznia int NOT NULL PRIMARY KEY,
      ...
);
b) ALTER TABLE tabela_uczniowie
ADD PRIMARY KEY (id_ucznia);

-- Nazwa PRIMARY KEY
a) CREATE TABLE tabela_uczniowie (
      id_ucznia int NOT NULL,
      imie varchar(20),
      nazwisko varchar(20),
      CONSTRAINT PK_ucznia PRIMARY KEY (id_ucznia)
);
b) ALTER TABLE tabela_uczniowie
ADD CONSTRAINT PK_ucznia PRIMARY KEY (id_ucznia);

-- Usuwanie PRIMARY KEY
ALTER TABLE tabela_uczniowie
DROP PRIMARY KEY (CONSTRAINT PK_ucznia);

-- FOREIGN KEY (klucz obcy)
a) CREATE TABLE zamówienia (
      id_zamówienia int NOT NULL PRIMARY KEY,
      id_osoby int, 
      nr_zamówienia int,
      FOREIGN KEY (id_osoby) REFERENCES widzowie (id_osoby)
);
b) ALTER TABLE zamówienia
ADD FOREIGN KEY (id_osoby) REFERENCES widzowie;

-- Nazwa FOREIGN KEY
a) CREATE TABLE zamówienia (
      id_zamówienia int NOT NULL PRIMARY KEY,
      id_osoby int, 
      nr_zamówienia int,
      CONSTRAINT FK_osoby FOREIGN KEY (id_osoby) REFERENCES widzowie (id_osoby)
); 
b) ALTER TABLE zamówienia
ADD CONSTRAINT FK_osoby FOREIGN KEY (id_osoby) REFERENCES widzowie (id_osoby);

-- Usuwanie FOREIGN KEY
ALTER TABLE zamówienia
DROP FOREIGN KEY (CONSTRAINT) FK_osoby;

-- CHECK
a)CREATE TABLE osoby (
    ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    imie varchar(20),
    nazwisko varchar(20),
    wiek int CHECK (wiek > 17)
);
b) ALTER TABLE osoby
ADD CHECK (wiek>=18);

-- Nazwa CHECK
a) CREATE TABLE osoby (
    ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    imie varchar(20),
    nazwisko varchar(20),
    wiek int,
    CONSTRAINT CHK_osoby CHECK (wiek > 17)
);
b) ALTER TABLE osoby ADD CONSTRAINT CHK_osoby CHECK (wiek>17 );

-- Usuwanie CHECK
ALTER TABLE osoby
DROP CONSTRAINT (CHECK) CHK_osoby;

-- DEFAULT
a) CREATE TABLE osoby (
    ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    imie varchar(20),
    nazwisko varchar(20),
    miasto varchar(255) DEFAULT 'Nowy Sącz'
);
b) ALTER TABLE osoby
ALTER miasto SET DEFAULT 'Nowy Sącz';

-- Usuwanie DEFAULT
ALTER TABLE osoby
ALTER (COLUMN) miasto DROP DEFAULT;

-- Tworzenie INDEXU
CREATE INDEX idx_dataUrodzenia
ON klienci (data_urodzenia);

-- Usuwanie INDEXU
ALTER TABLE klienci
DROP INDEX idx_dataUrodzenia;

-- AUTO_INCREMENT (autonumerowanie rekordów)
CREATE TABLE osoby (
    ID int AUTO_INCREMENT PRIMARY KEY
    ...
);

-- Zmiana początkowej wartości autonumerowania
ALTER TABLE osoby AUTO_INCREMENT=100; 

-- Tworzenie widoku o nazwie 'Ceny_produktów', który zawiera kolumny nazwa_produktu i cena z tabeli produkty
CREATE VIEW Ceny_produktów AS
SELECT nazwa_produktu, cena FROM produkty;

lub lepiej

CREATE OR REPLACE VIEW Ceny_produktów AS
SELECT nazwa_produktu, cena FROM produkty;

-- Usuwanie widoku
DROP VIEW Ceny_produktów;

                        DATY

-- Typy zapisu dat
a) DATA (RRRR-MM-DD)
b) DATETIME (RRRR-MM-DD GG:MI:SS)
c) TIMESTAMP (RRRR-MM-DD GG:MI:SS)
d) TIME (HH:MI:SS)
e) YEAR (YYYY lub YY)

Uwaga: DATETIME służy do samodzielnego wpisywania daty  w rekordzie a TIMESTAMP automatycznie przypisuje aktualny czas wprowadzenia ostatniej modyfikacji rekordu

-- Wyświetlanie aktualnej daty i czasu
SELECT NOW(); (RRRR-MM-DD GG:MI:SS)

-- Wyświetlanie aktualnej daty
SELECT CURDATE(); (RRRR-MM-DD)

-- Wyświetlanie aktualnego czasu
SELECT CURTIME(); (GG:MI:SS)

-- Wybieranie daty 
SELECT DATE(RRRR-MM-DD);

-- Wyciąganie z daty konkretnego dnia, miesiąca, itd.
SELECT EXTRACT(DAY from "RRRR-MM-DD GG:MI:SS");

-- Dodawanie (Odejmowanie) do podanej daty dni, miesięcy, minut itd.
SELECT DATE_ADD (DATE_SUB)("RRRR-MM-DD GG:MI:SS", INTERVAL 32 SECOND);

-- Różnica dni pomiędzy dwiema datami
SELECT DATEDIFF("RRRR-MM-DD", "RRRR-MM-DD");

-- Format daty
SELECT DATE_FORMAT("RRRR-MM-DD GG:MI:SS", "%Y %M %D");

                  FUNKCJE STRING
                     
-- Zmiana wszystkich liter na duże
SELECT UCASE("ABCdefgHi"); => "ABCDEFGHI"

-- Zmiana wszystkich liter na małe
SELECT LCASE("ABCdefgHi"); => "abcdefghi"

-- Wycinanie liter ze stringa
SELECT MID("ABCdefgHi", 2, 3); => "BCd" lub SELECT SUBSTRING...;
SELECT LEFT("ABCdefgHi", 3); => "ABC"
SELECT RIGHT("ABCdefgHi", 3); => "gHi"

-- Ilość znaków w stringu
SELECT LENGHT("ABCdefgHi"); => "9"

-- Sklejanie dwóch lub więcej wyrażeń
SELECT CONCAT("I ", "like ", "winter", ".") AS SklejoneSłowa; => "I like winter."

-- Zamiana stringa na inny wyraz
SELECT REPLACE('ABCdefgHi', 'def', 'DEF'); => "ABCDEFgHi"

-- Powtórzenie stringu dowolną ilość razy
SELECT REPEAT('ABCdefgHi ', 2); => "ABCdefgHi ABCdefgHi"

-- Zapisanie stringu od końca
SELECT REVERSE('ABCdefgHi'); => "iHgfedCBA"

                  FUNKCJE LICZBOWE

-- Zaokrąglanie w górę liczby do konkretnego miejsca po przecinku
SELECT ROUND(123.456, 1) => 123.5

-- Zaokrąglanie liczby w dół (niezależnie od tego co jest po przecinku)
SELECT FLOOR(123.999); => 123

-- Zaokrąglanie liczby w górę (niezależnie od tego co jest po przecinku)
SELECT CEIL(123.001); => 124 lub SELECT CEILING...;

-- Obcinanie liczby miejsc po przecinku 
SELECT TRUNCATE(123.999, 2); => 123.99

-- Reszta z dzielenia
SELECT MOD(8, 6); => 2

-- Potęga liczby
SELECT MOD(8, 2); => 64

-- Zwracanie wartości liczby pi
SELECT PI();

-- Wartość pierwiatka kwadratowego z danej liczby 
SELECT SQRT(100); => 10

                  FUNKCJE HASHUJĄCE

-- Funkcja MD5
SELECT MD5('piotr1234'); => np: 'e0698b5367c3235b0d5652ad720069a9' - zawsze będzie się składało z 32 znaków.

-- Funkcja SHA-1
SELECT SHA1('QWERTY'); => np: '65e21ea0de8852abc2b0d821c1f9ac6f2cd5bd98' - zawsze będzie się składało z 40 znaków.

-- Funkcja SHA-2 (posiada 6 odmian; dwie nie zostały jak na razie złamane)
a) SELECT SHA2('12345678', 256); => np: 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f' - zawsze będzie się składało z 64 znaków.
b) SELECT SHA2('q1w2e3r4t5y', 512); => np: '86b3d34462b5c6e813941c7c511939c4e1af610b648b18de2d1a9ccfdcfe01ddd4dd37fd8eb2b2fa12a4d69f4dcc21bf67eb5de7485ea5a134676506245d6135' - zawsze będzie się składało z 128 znaków.

-- Funkcja ENCRYPT (nie działa w systemie Windows)
SELECT ENCRYPT('12345abc', 'ab');

-- Tworzenie nowego użytkownika
CREATE USER 'djudka'@'localhost' IDENTIFIED BY 'qwerty';

-- Usuwanie użytkownika
DELETE FROM user where user.host = 'localhost' AND user.User = 'djudka';

-- Nadawanie uprawnień użytkownikowi
GRANT SELECT, INSERT, ALTER ON *.* TO 'djudka'@'localhost';

-- Odbieranie uprawnień użytkownikowi
REVOKE SELECT, INSERT, ALTER ON *.* FROM 'djudka'@'localhost';

-- Użytkownik może nadawać uprawnienia innym użytkownikom
GRANT...ON...TO...WITH GRANT OPTION;

                 TWORZENIE FUNKCJI
-- a) deklaracja funkcji
CREATE FUNCTION dodaj(a int, b int)
RETURNS int
RETURN a + b;

-- b) wywołanie funkcji
SELECT dodaj("5", "4"); --> Wynik: 9

-- c) usuwanie funkcji
DROP FUNCTION dodaj;

                 TWORZENIE PROCEDUR
-- Zmiana znaku kończącego kwerendę 
DELIMITER \\;

-- a) treść procedury
CREATE PROCEDURE nazwa_procedury(OUT wyjście INT)
BEGIN
      DECLARE zmienna INT;
      SET zmienna = 50;
      etykieta: WHILE zmienna <= 300 DO
      SET zmienna = zmienna*2;
      END WHILE etykieta;
      SET wyjście = zmienna;
END;

-- c) wywołanie procedury
CALL nazwa_procedury(@zmienna);

-- d) usuwanie procedury
DROP PROCEDURE nazwa_procedury;

                 FUNKCJE DATY(podstawowe)
-- a)Zwraca aktualną i czas(YYYY-MM-DD HH-MM-SS)
CURRENT_TIMESTAMP()/NOW()


-- b)Zwraca aktualną datę(YYYY-MM-DD)
CURRENT_DATE()/CURDATE()

-- c)Zwraca aktualny czas(HH-MM-SS)
CURRENT_TIME()/CURTIME()

-- d)Wybiera z wyrażenia samą datę
DATE("2017-06-15 09:34:21"); -> Wynik: 2017-06-15

-- e)Zwraca różnicę w dniach pomiędzy dwoma datami
DATEDIFF("2017-06-25", "2017-06-15"); -> Wynik: 10

-- f)Dodaje przedział czasu/daty do daty i zwraca nową datę
DATE_ADD("2017-06-15", INTERVAL 10 DAY); -> Wynik: 2017-06-25

-- Składnia DATE_ADD:
DATE_ADD(data, INTERVAL wartość 'addunit', np. DAY);

-- g)Odejmuje przedział czasu/daty od daty i zwraca nową datę 
DATE_SUB("2017-06-15", INTERVAL 10 DAY); -> Wynik: 2017-06-05

-- Składnia DATE_SUB:
DATE_SUB(data, INTERVAL wartość 'interval', np. DAY);

-- h)Formatuje datę zgodnie z podaną wartością
DATE_FORMAT("2017-06-15", "%Y"); -> Wynik: 2017

-- Składnia DATE_FORMAT:
DATE_FORMAT(data, format, np. %H(godzina));

-- i)Wyciąga z część z podanej daty
EXTRACT(MONTH FROM "2017-06-15"); -> Wynik: 6

-- Składnia EXTRACT:
EXTRACT(część, np. DAY FROM data);

-- j)Tworzy i zwraca datę na podstawie roku i liczby dni
MAKEDATE(2020, 250); -> Wynik: 2020-09-06

-- Składnia MAKEDATE:
MAKEDATE(rok(4 cyfry), dzień(nr roku od 1 do 365/ 366));

-- k)Zwraca: 

-- bez argumentu liczbę sekund od początku ery Unixowej(1970-01-01 00:00:00)
UNIX_TIMESTAMP();

-- z argumentem daty liczbę sekund od początku ery Unixowej(1970-01-01 00:00:00) do argumentu
UNIX_TIMESTAMP('1970-01-01 00:00:01'); -> Wynik: 1


Andreasik 1
Bajorek   2
Basta     3
Brattig   4 
Bugara    5 
Dutka     6 
Dyrek     7 
Fałowska  8
Firlej    9
Grygiel   10
Huza      11
Jachowicz 12
Juda      13
Judka     14
Kois      15
Korek     16
Koszyk    17
Koszyk    18
Kowalczyk 19
Krawczyk  20
Leśniak   21
Leśniak   22
Michalik  23
Obrzut    24
Ogórek    25
Ojczyk    26
Olchawa   27
Ordon     28
Prusak    29
Szczecina 30
Wajda     31
Węgielski 32