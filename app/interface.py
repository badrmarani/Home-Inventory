import os, time

from app.src.home_app import print_products, print_results, add_new_product, change_password, delete_product

def home(username = None) :
    print (f"""
        Bonjour {username},
        ------------------------------------------------------------------------------------------------
        Application                             {time.time}                                Home Invetory
        ------------------------------------------------------------------------------------------------

            1 . Afficher la liste des produits
            2 . Afficher les derniers résultats de contrôle des produits
            3 . Changer le mot de passe
            4 . Ajouter un nouveau produit
            5 . Supprimer produit

            -1 . Quitter

        ------------------------------------------------------------------------------------------------
        ------------------------------------------------------------------------------------------------
    """)

    while True :
        num = input("Votre choix\t"); os.system('cls')
        if num == "1" :
            print_products()
        elif num == "2" :
            print_results()
        elif num == "3" :
            change_password(username)
        elif num == "4" :
            add_new_product()
        elif num == "5" :
            delete_product()
        elif num == "-1" :
            time.sleep(1); os._exit(0)
        else :
            print("ERREUR ... Saisie incorrecte")
        home()
