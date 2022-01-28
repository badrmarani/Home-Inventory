import mysql.connector
import time
import os

connection = mysql.connector.connect(
    host = 'localhost',
    port = '3306',
    database = 'Home',
    user = 'root',
    password = 'toor'
)
cursor = connection.cursor()

def print_products() :
    cursor.execute("""
        SELECT product_name, category_name
        FROM Product, Category
        WHERE Product.category_id = Category.category_id
    """)
    data = cursor.fetchall()

    print("+------------------------------------------------------------------------------------------------------+")
    print("Nombre des produits : ", len(data))
    print("+------------------------------------------------------------------------------------------------------+")
    print("Liste des produits :")
    print("+------------------------------------------------------------------------------------------------------+")
    i = 0
    for d in data :
        print("Produit N°{:<12}\t{:<35}\t\tCatégorie : {:<12}".format(i, d[0], d[1]), end='\n'); i += 1
    print("+------------------------------------------------------------------------------------------------------+")

    if input("Revenir à l'interface d'accueil...") != '' :
        os.system('cls');


def print_results() :
    cursor.execute("""
        SELECT product_name, control_results
        FROM Product, Control, Stock
        Where
        	Control.stock_id = Stock.stock_id AND
            Stock.product_id = Product.product_id
        GROUP by product_name
    """)
    data = cursor.fetchall()

    print("+------------------------------------------------------------------------------------------------------+")
    print("Nombre des produits : ", len(data))
    print("+------------------------------------------------------------------------------------------------------+")
    print("Liste des produits, ainsi que leurs résultats:")
    print("+------------------------------------------------------------------------------------------------------+")
    i = 0
    for d in data :
        print("Produit N°{:<12}\t{:<30}\t\tRésultats : {:<12}".format(i, d[0], d[1]), end='\n'); i += 1
    print("+------------------------------------------------------------------------------------------------------+")

    if input("Revenir à l'interface d'accueil...") != '' :
        os.system('cls');

def change_password(Username = None) :
    print("+------------------------------------------------------------------------------------------------------+")
    Password1 = input("Entrez votre mot de passe :\t")
    Password2 = input("Confirmez votre mot de passe :\t")
    print("+------------------------------------------------------------------------------------------------------+")

    if Password1 == Password2 :

        cursor.execute("""
            UPDATE User
            SET
                user_password = {}
            WHERE
                user_name = {};
        """.format(Username, Password1))
        connection.commit()

        print("Mot de passe changée avec succès !")

    print("+------------------------------------------------------------------------------------------------------+")
    if input("Revenir à l'interface d'accueil...") != '' :
        os.system('cls');

def delete_product() :
    print("+------------------------------------------------------------------------------------------------------+")
    name = input("Entrez le nom de produit :\t")
    print("+------------------------------------------------------------------------------------------------------+")

    cursor.execute("""
        DELETE FROM User
        WHERE product_name = {}
    """.format(name))
    connection.commit()

    print("Produit supprimée avec succès !")


def add_new_product() :
    print("+------------------------------------------------------------------------------------------------------+")
    name = input("Entrez le nom de produit :\t")
    taille = input("Entrez le libellé de sa taille :\t")
    temp_min = input("Entrez sa temperature minimal :\t")
    temp_max = input("Entrez sa temperature maximal :\t")
    desc = input("Entrez une description de produit :\t")
    print("+------------------------------------------------------------------------------------------------------+")

    cursor.execute("""
        insert into Product
            (product_name, product_temperature_max, product_temperature_min, product_description, shape_id, information_id, category_id) values
            ({}, {}, {}, {}, {}, {}, {});
    """.format(name, temp_min, temp_max, desc, 1, 1, 1))
    connection.commit()


    print("Mot de passe ajoutée avec succès !")

    print("+------------------------------------------------------------------------------------------------------+")
    if input("Revenir à l'interface d'accueil...") != '' :
        os.system('cls');
