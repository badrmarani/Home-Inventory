--
-- Database : Home
--
DROP 	DATABASE IF EXISTS Home;
CREATE DATABASE IF NOT EXISTS Home;
USE Home;

--
-- Structure de la table : Shape
--
DROP TABLE IF EXISTS Shape;
CREATE TABLE IF NOT EXISTS Shape (
    shape_id INT NOT NULL AUTO_INCREMENT,

    shape_name VARCHAR(50) NOT NULL,
    shape_height VARCHAR(50) NOT NULL,
    shape_weight VARCHAR(50) NOT NULL,
    shape_volume VARCHAR(50) NOT NULL,

    PRIMARY KEY (shape_id)
);

--
-- Structure de la table : Information
--
DROP TABLE IF EXISTS Information;
CREATE TABLE IF NOT EXISTS Information (
    information_id INT NOT NULL AUTO_INCREMENT,

    information_expiration_date DATETIME NOT NULL,
    information_entry_date DATETIME NOT NULL,
    information_unit_price INT NOT NULL,
    information_quantity INT NOT NULL,

    PRIMARY KEY (information_id)
);

--
-- Structure de la table : Category
--
DROP TABLE IF EXISTS Category;
CREATE TABLE IF NOT EXISTS Category (
    category_id INT NOT NULL AUTO_INCREMENT,

    category_name VARCHAR(50) NOT NULL,

    PRIMARY KEY (category_id)
);

--
-- Structure de la table : City
--
DROP TABLE IF EXISTS City;
CREATE TABLE IF NOT EXISTS City (
    zip_code INT NOT NULL AUTO_INCREMENT,

    city_name VARCHAR(50) NOT NULL,

    PRIMARY KEY (zip_code)
);

--
-- Structure de la table : Product
--
DROP TABLE IF EXISTS Product;
CREATE TABLE IF NOT EXISTS Product (
    product_id INT NOT NULL AUTO_INCREMENT,

    shape_id INT NOT NULL,
    information_id INT NOT NULL,
    category_id INT NOT NULL,

    product_name VARCHAR(50) NOT NULL,
    product_temperature_max VARCHAR(50) NOT NULL,
    product_temperature_min VARCHAR(50) NOT NULL,
    product_description VARCHAR(50) NOT NULL,

    PRIMARY KEY (product_id),
    FOREIGN KEY (shape_id) REFERENCES Shape(shape_id),
    FOREIGN KEY (information_id) REFERENCES Information(information_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

--
-- Structure de la table : Stock
--
DROP TABLE IF EXISTS Stock;
CREATE TABLE IF NOT EXISTS Stock (
    stock_id INT NOT NULL AUTO_INCREMENT,

    product_id INT NOT NULL,

    stock_name VARCHAR(50) NOT NULL,

    PRIMARY KEY (stock_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

--
-- Structure de la table : User
--
DROP TABLE IF EXISTS User;
CREATE TABLE IF NOT EXISTS User (
    user_id INT NOT NULL AUTO_INCREMENT,

    stock_id INT NOT NULL,

    user_name VARCHAR(50) NOT NULL,
    user_password VARCHAR(50) NOT NULL,
    user_last_session DATETIME NOT NULL,

    PRIMARY KEY (user_id),
    FOREIGN KEY (stock_id) REFERENCES Stock(stock_id)
);

--
-- Structure de la table : Company
--
DROP TABLE IF EXISTS Company;
CREATE TABLE IF NOT EXISTS Company (
    company_id INT NOT NULL AUTO_INCREMENT,

    product_id INT NOT NULL,

    company_name VARCHAR(50) NOT NULL,
    company_email VARCHAR(50) NOT NULL,
    company_description VARCHAR(50) NOT NULL,

    PRIMARY KEY (company_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

--
-- Structure de la table : Control
--
DROP TABLE IF EXISTS Control;
CREATE TABLE IF NOT EXISTS Control (
    control_id INT NOT NULL AUTO_INCREMENT,

    stock_id INT NOT NULL,

    control_date DATETIME NOT NULL,
    control_results VARCHAR(50) NOT NULL,

    PRIMARY KEY (control_id),
    FOREIGN KEY (stock_id) REFERENCES Stock(stock_id)
);

--
-- Structure de la table : BELONGING
--
DROP TABLE IF EXISTS BELONGING;
CREATE TABLE IF NOT EXISTS BELONGING (
    zip_code INT NOT NULL,
    company_id INT NOT NULL,

    FOREIGN KEY (zip_code) REFERENCES City(zip_code),
    FOREIGN KEY (company_id) REFERENCES Company(company_id),
    CONSTRAINT PRIMARY KEY (
        zip_code,
        company_id
    )
);

--
-- Contraintes d'intégrité
--

ALTER TABLE Product
ADD CONSTRAINT
    CHECK (
        product_temperature_max > 0 AND
        product_temperature_min > 0
    );

ALTER TABLE Shape
ADD CONSTRAINT
    CHECK (
        shape_height > 0 AND
        shape_weight > 0 AND
        shape_volume > 0
    );

ALTER TABLE Information
ADD CONSTRAINT
    CHECK (
        information_quantity > 0 AND
        information_unit_price > 0
    );

ALTER TABLE Control
MODIFY control_results ENUM (
    'Produit est périmé',
    'Produit est disponible',
    'Produit n est pas disponile'
);

--
-- Contenu de la table Shape
--
INSERT INTO Shape
    (shape_name, shape_height, shape_weight, shape_volume) VALUES
    ('SY', '68', '33', '74'),
    ('HR', '73', '69', '45'),
    ('RU', '11', '99', '17'),
    ('CN', '55', '84', '06'),
    ('RU', '81', '08', '71'),
    ('TN', '31', '78', '87'),
    ('FR', '19', '28', '58'),
    ('US', '96', '82', '19'),
    ('CO', '24', '03', '51');

--
-- Contenu de la table Information
--
INSERT INTO Information
    (information_entry_date, information_expiration_date, information_unit_price, information_quantity) VALUES
    ('2021-07-24', '2021-12-04', 80, 7),
    ('2021-06-15', '2021-07-10', 87, 9),
    ('2021-09-06', '2021-10-08', 89, 32),
    ('2021-07-16', '2021-08-03', 42, 3),
    ('2021-07-01', '2021-08-19', 51, 5),
    ('2022-01-18', '2021-12-25', 89, 9),
    ('2021-04-30', '2021-09-02', 59, 42),
    ('2021-07-10', '2021-10-24', 18, 14),
    ('2021-10-12', '2021-11-23', 39, 32),
    ('2021-02-15', '2021-04-10', 63, 7);

--
-- Contenu de la table Category
--
INSERT INTO Category (category_name) VALUES ('Rhamnaceae');
INSERT INTO Category (category_name) VALUES ('Poaceae');
INSERT INTO Category (category_name) VALUES ('Onagraceae');
INSERT INTO Category (category_name) VALUES ('Scrophulariaceae');
INSERT INTO Category (category_name) VALUES ('Convolvulaceae');
INSERT INTO Category (category_name) VALUES ('Papaveraceae');
INSERT INTO Category (category_name) VALUES ('Parmeliaceae');
INSERT INTO Category (category_name) VALUES ('Asteraceae');
INSERT INTO Category (category_name) VALUES ('Oleaceae');
INSERT INTO Category (category_name) VALUES ('Malvaceae');

--
-- Contenu de la table City
--
INSERT INTO City (zip_code, city_name) VALUES (175658, 'Kovářská');
INSERT INTO City (zip_code, city_name) VALUES (256413, 'Puubheto');
INSERT INTO City (zip_code, city_name) VALUES (775677, 'Zhonghe');
INSERT INTO City (zip_code, city_name) VALUES (655166, 'Silihe');
INSERT INTO City (zip_code, city_name) VALUES (897027, 'Felege Neway');
INSERT INTO City (zip_code, city_name) VALUES (899439, 'Chonglou');
INSERT INTO City (zip_code, city_name) VALUES (339793, 'Putrajaya');
INSERT INTO City (zip_code, city_name) VALUES (179159, 'Sydney');
INSERT INTO City (zip_code, city_name) VALUES (565187, 'Krrabë');
INSERT INTO City (zip_code, city_name) VALUES (233476, 'Trảng Bàng');

--
-- Contenu de la table Product
--
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Wine - Acient Coast Caberne', 12, 37, 'Suspendisse accumsan', 1, 10, 2);
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Cake Circle, Foil, Scallop', 16, 36, 'Cras mi pede, malesuada in, imperdiet ', 1, 1, 9);
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Poppy Seed', 19, 33, 'Mauris enim leo, rhoncus sed, vestibulum sit amet', 2, 4, 9);
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Cookie - Dough Variety', 11, 24, 'Aenean lectus.', 6, 5, 6);
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Chilli Paste, Hot Sambal Oelek', 10, 23, 'Pellentesque ultrices mattis', 5, 7, 1);
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Apricots - Dried', 4, 23, 'Donec ut dolor. Morbi', 4, 3, 7);
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Bagel - Everything', 16, 39, 'Duis consequat dui nec', 7, 5, 3);
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Soup Campbells Split Pea And Ham', 9, 33, 'Morbi vel lectus in ', 6, 9, 4);
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Oil - Shortening - All - Purpose', 14, 31, 'Vivamus metus arcu', 2, 8, 8);
INSERT INTO Product (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) VALUES ('Cheese Cloth No 100', 10, 35, 'Lorem ipsum', 1, 1, 1);

--
-- Contenu de la table Stock
--
INSERT INTO Stock (stock_name, product_id) VALUES ('620lnp1d', 2);
INSERT INTO Stock (stock_name, product_id) VALUES ('148ubs4w', 7);
INSERT INTO Stock (stock_name, product_id) VALUES ('704qfc2o', 6);
INSERT INTO Stock (stock_name, product_id) VALUES ('128skm4t', 3);
INSERT INTO Stock (stock_name, product_id) VALUES ('003asp2x', 4);
INSERT INTO Stock (stock_name, product_id) VALUES ('276tjs8o', 3);
INSERT INTO Stock (stock_name, product_id) VALUES ('439sju0o', 4);
INSERT INTO Stock (stock_name, product_id) VALUES ('693qau6d', 3);
INSERT INTO Stock (stock_name, product_id) VALUES ('675iul3d', 8);
INSERT INTO Stock (stock_name, product_id) VALUES ('138swu1v', 3);


--
-- Contenu de la table User
--
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Robinetta', 'Sefo0Jh2', '2021-06-22', 9);
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Obediah', '8mW43NqsnnrT', '2022-01-26', 8);
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Bastien', 'NZ4f2OSgAkiQ', '2022-01-10', 6);
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Philbert', 'XJDEdC', '2021-05-14', 3);
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Bonny', 'TSBxbqhxWDHf', '2022-01-14', 6);
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Town', 'hm84jRD9uiTo', '2021-04-05', 3);
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Nolly', 'd0cDfXWO', '2021-03-21', 2);
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Astra', '5xcwmvJi7', '2021-10-21', 6);
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Camala', 'DDUDr5iXd2u', '2022-01-21', 2);
INSERT INTO user (user_name, user_password, user_last_session, stock_id) VALUES ('Ellie', 's5BEa270', '2021-06-21', 2);

--
-- Contenu de la table Company
--
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('Corwin and Sons', 'Witting-Dooley', 'Lehner, Schaden and Dach', 10);
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('Okuneva-Abshire', 'Kiehn Group', 'Deckow, Murazik and Reynolds', 1);
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('O''Hara, Runte and Beahan', 'Hermann-Rohan', 'Kertzmann-Streich', 2);
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('Steuber-Fay', 'Hackett-Rolfson', 'Herman-Mitchell', 5);
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('Hintz, Bauch and Gleichner', 'Stanton-Littel', 'Cummerata LLC', 1);
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('Runolfsson-Denesik', 'Larkin, Cummerata and Stehr', 'Cremin, Lind and Stehr', 4);
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('Witting Inc', 'Miller, Kohler and Okuneva', 'Bartell LLC', 3);
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('Mraz, Cremin and Thiel', 'Lowe LLC', 'Ullrich Inc', 10);
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('Armstrong LLC', 'Flatley-Collier', 'Torp-Harber', 6);
INSERT INTO Company (company_name, company_email, company_description, product_id) VALUES ('Hoppe-Smitham', 'Spinka, Dickens and Abshire', 'Muller, Pacocha and Kuhn', 5);

--
-- Contenu de la table Company
--
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2021-08-15', 'Produit est périmé', 4);
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2021-04-14', 'Produit est disponible', 4);
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2021-06-12', 'Produit est périmé', 8);
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2021-06-06', 'Produit est disponible', 6);
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2021-07-03', 'Produit est périmé', 5);
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2021-03-22', 'Produit est disponible', 6);
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2022-01-21', 'Produit est périmé', 10);
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2021-06-05', 'Produit est disponible', 7);
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2021-04-26', 'Produit n est pas disponile', 4);
INSERT INTO Control (control_date, control_results, stock_id) VALUES ('2021-08-16', 'Produit n est pas disponile', 2);

--
-- Contenu de la table Belonging
--
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 4);
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 6);
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 1);
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 9);
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 3);
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 10);
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 8);
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 5);
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 2);
INSERT INTO BELONGING (zip_code, company_id) VALUES (339793, 7);
