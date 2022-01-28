--
-- Database : Home
--
DROP DATABASE IF EXISTS Home;
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

    category_nom VARCHAR(50) NOT NULL,

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
        shape_volume > 0 AND
    );

ALTER TABLE Information
ADD CONSTRAINT
    CHECK (
        information_quantity > 0 AND
        information_entry_date <= information_expiration_date AND
        information_unit_price > 0
    );

ALTER TABLE Control
MODIFY control_results ENUM (
    'Produit est périmé',
    'Produit est disponible',
    'Produit n est pas disponile'
);


--
-- Contenu de la table user
--
INSERT INTO User
    (user_name, user_password, user_last_session, stock_id) VALUES
    ('Casey', 'Smnf3sXD6', '2021-08-22', 1),
    ('Jeromy', 'qtD4rXlJNHx', '2021-10-27', 2),
    ('Kelby', 'NnazZcgf0H', '2021-10-27', 7),
    ('Elbert', 'KBB0Y3FR', '2021-10-27', 9),
    ('Gail', 'KWUzv9eqB', '2021-10-27', 6),
    ('Devora', 'qYlGSdWCxS', '2021-10-27', 5),
    ('Melany', 'YJ42N4', '2021-10-27', 10),
    ('Cesar', 'Fk6hq7irb', '2021-10-27', 3),
    ('Ramsay', 'cRtZnV', '2021-10-27', 4),
    ('Dal', 'IVGCHm6hsZ', '2021-10-27', 8);
